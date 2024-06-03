import streamlit as st
import random
import time
from openai import OpenAI
import openai
from snowflake import connector
from langchain.embeddings import OpenAIEmbeddings
from typing import List


def get_db_connection():
    return connector.connect(
        account=st.secrets["SNOWFLAKE_HOST"],
        role=st.secrets["SNOWFLAKE_ROLE"],
        warehouse=st.secrets["SNOWFLAKE_WAREHOUSE"],
        database=st.secrets["SNOWFLAKE_DATABASE"],
        schema=st.secrets["SNOWFLAKE_SCHEMA"],
        user=st.secrets["SNOWFLAKE_USERNAME"],
        password=st.secrets["SNOWFLAKE_PASSWORD"],
    )

def get_similar_chunks(query_vector, table_names) -> List[str]:
        conn = get_db_connection()
        cursor = conn.cursor()

        chunks = [] 
        for table_name in table_names:
            query = f"""
            SELECT document_content, VECTOR_COSINE_SIMILARITY(embedding, CAST({query_vector} AS VECTOR(FLOAT, 1536))) AS similarity
            FROM {table_name}
            ORDER BY similarity DESC
            LIMIT 2
            """
            cursor.execute(query)
            result = cursor.fetchall()
            chunks += [item[0] for item in result]
        cursor.close()
        conn.close()

        return chunks

def get_completion(question, document_chunks: List[str], model_name: str = "llama2-70b-chat"):
        conn = get_db_connection()
        cur = conn.cursor()

        chunks = "\n\n".join(document_chunks)

        query = f"""
        SELECT snowflake.cortex.complete(
        '{model_name}', 
        CONCAT( 
            'You are an Airbyte product assistant. Answer the question based on the context. Be concise. When returning a list of items, Please enumerate description on separate lines','Context: ',
            $$
            {chunks}
            $$,
        'Question: ', 
        $$ {question} $$,
        'Answer: '
        )
        ) as response;"""
        cur.execute(query)
        result = cur.fetchall()
        cur.close()
        conn.close()
        # TO-DO: better parsing here 
        return result[0][0].strip()


def get_user_intent(query):
    # this method does a simple few shots classifcation to help get user's intent

    examples = [
        {"role": "system", "content": "You are an assistant that classifies user intents based on their messages."},
        {"role": "user", "content": "How can I add vector data in Snowflake?"},
        {"role": "assistant", "content": "docs_question"},
        {"role": "user", "content": "How do I set up Snowflake Cortex destination?"},
        {"role": "assistant", "content": "docs_question"},
        {"role": "user", "content": "What are the upcoming features for Snowflake Cortex?"},
        {"role": "assistant", "content": "github_question"},
        {"role": "user", "content": "What are the known issues for Snowflake Cortex?"},
        {"role": "assistant", "content": "github_question"},
        {"role": "user", "content": "Which customers have requested features for Snowflake Cortex?"},
        {"role": "assistant", "content": "zendesk_question"},
        {"role": "user", "content": "Which customers have requested authorization related features for Snowflake Cortex?"},
        {"role": "assistant", "content": "zendesk_question"},
    ]
    examples.append({"role": "user", "content": query})
    openai.api_key = st.secrets["OPENAI_API_KEY"]
    # Call the OpenAI chat API to get the intent classification
    response = openai.chat.completions.create(
        model="gpt-3.5-turbo", 
        messages=examples,
        max_tokens=10,
        n=1,
        stop=["\n"]
    )

    intent = response.choices[0].message.content    
    return intent

def get_tables_to_query(query):
        intent = get_user_intent(query)
       
        if intent == "github_question":
            return (["airbyte_github_issues"], "llama2-70b-chat")
        elif intent == "zendesk_question":
            return (["airbyte_zendesk_tickets", "airbyte_zendesk_users"], "llama2-70b-chat")
        else:
            # default 
            return(["airbyte_docs"], "snowflake-arctic")       


def get_response(query):
        # embed the query 
        embeddings = OpenAIEmbeddings(openai_api_key=st.secrets["OPENAI_API_KEY"])
        # get similar chunks from sources/tables in Snowflake
        [tables, model] = get_tables_to_query(query)
        chunks = get_similar_chunks(embeddings.embed_query(query), tables)
        if (len(chunks) == 0):
            return "I am sorry, I do not have the context to answer your question."
        else:
            return get_completion(query, chunks, model)


def response_generator(query):
    response = get_response(query)
    # Split the response by spaces but preserve the new lines
    parts = []
    current_part = []
    for char in response:
        if char in ['\n', ' ']:
            if current_part:
                parts.append(''.join(current_part))
                current_part = []
            if char == '\n':
                parts.append('\n')
            else:
                parts.append(' ')
        else:
            current_part.append(char)
    if current_part:
        parts.append(''.join(current_part))

    for part in parts:
        yield part
        time.sleep(0.01)



st.title("AI Product assistant")

# simulate initial message from assistant
initial_message = """👋 Hello! I'm here to help you with any questions you have on Airbyte's products or services. 
How can I assist you today?"""

# Display initial message from assistant
with st.chat_message("assistant"):
    st.write(initial_message)

# Recommended questions section in the sidebar
st.sidebar.title("Recommended Questions")
recommended_questions = [
    "How can I add vector data in Snowflake?",
    "What are the upcoming features for Snowflake Cortex?",
    "Which customers have requested features for Snowflake Cortex?",
]
for question in recommended_questions:
    st.sidebar.markdown(f"- {question}")


client = OpenAI(api_key=st.secrets["OPENAI_API_KEY"])

# Set a default model
if "openai_model" not in st.session_state:
    st.session_state["openai_model"] = "gpt-3.5-turbo"

# Initialize chat history
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat messages from history on app rerun
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

if prompt := st.chat_input("Ask a question?"):
    # Display user message in chat message container
    with st.chat_message("user"):
        st.markdown(prompt)
    # Add user message to chat history
    st.session_state.messages.append({"role": "user", "content": prompt})

    with st.chat_message("assistant"):
        response = st.write_stream(response_generator(prompt))
     # Add assistant response to chat history
    st.session_state.messages.append({"role": "assistant", "content": response})

