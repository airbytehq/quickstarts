import os
import pinecone

from rich.console import Console
from rich.markdown import Markdown

import langchain
from langchain.prompts import PromptTemplate
from langchain.chains import RetrievalQA
from langchain.embeddings import OpenAIEmbeddings
from langchain.llms import OpenAI
from langchain.vectorstores import Pinecone

# langchain.debug = True

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
PINECONE_API_KEY = os.getenv("PINECONE_KEY")
PINECONE_ENVIRONMENT = os.getenv("PINECONE_ENVIRONMENT")
PINECONE_INDEX = os.getenv("PINECONE_INDEX")

embeddings = OpenAIEmbeddings(openai_api_key=OPENAI_API_KEY)
pinecone.init(api_key=PINECONE_API_KEY, environment=PINECONE_ENVIRONMENT)
index = pinecone.Index(PINECONE_INDEX)
vector_store = Pinecone(index, embeddings, "text")

prompt_template = """
You are a question-answering bot for Airbyte company employees and will be provided
relevant context from Notion pages on the Airbyte company knowlege base.

Whenever you are asked a question you answer with a helpful answer if you can, along
with the links to those relevant pages for further information. If you are not sure, you
will say that you are not sure but still provide links if anything might be helpful to the
questioner.

Only use the provided context. Do not guess and do not use prior knowlege.

Please provide your response in markdown format, starting with a level 2 header that describes
the answer under a reasonable summary header.

Notion context for this question:
{context}

Question: {question}

Please provide a helpful answer along one or more URLs that would be helpful for finding additional information:
"""

prompt = PromptTemplate(
    template=prompt_template, input_variables=["context", "question"]
)

qa = RetrievalQA.from_chain_type(
    llm=OpenAI(temperature=0, openai_api_key=OPENAI_API_KEY),
    chain_type="stuff",
    retriever=vector_store.as_retriever(),
    chain_type_kwargs={"prompt": prompt},
)

console = Console()

console.print(Markdown("\n------\n> What do you want to know?"))
console.print("")
while True:
    try:
        query = input("")
    except KeyboardInterrupt:
        console.print("\n")
        console.print(Markdown("_Goodbye!_ 👋"))
        exit(0)

    answer = qa.run(query)
    console.print(Markdown(answer))

    console.print(Markdown("\n------\n> What else do you want to know?\n"))
    console.print("\n")
