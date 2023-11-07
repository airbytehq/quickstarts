import os
import pinecone

from langchain.prompts import PromptTemplate
from langchain.chains import RetrievalQA
from langchain.embeddings import OpenAIEmbeddings
from langchain.llms import OpenAI
from langchain.vectorstores import Pinecone

embeddings = OpenAIEmbeddings(openai_api_key=os.getenv("OPENAI_API_KEY"))
pinecone.init(api_key=os.getenv("PINECONE_API_KEY"), environment=os.getenv("PINECONE_ENVIRONMENT"))
index = pinecone.Index(os.getenv("PINECONE_INDEX"))
vector_store = Pinecone(index, embeddings, "text")

prompt_template = """You are a question-answering bot for employees and will be provided relevant context from Notion pages. When possible, include where you got the answer from when available.

Context for this question:
{context}

Question: {question}

Helpful answer:"""

prompt = PromptTemplate(template=prompt_template, input_variables=["context", "question"])

qa = RetrievalQA.from_chain_type(llm=OpenAI(temperature=0, openai_api_key=os.getenv("OPENAI_API_KEY")), chain_type="stuff", retriever=vector_store.as_retriever(), chain_type_kwargs={"prompt": prompt})

print("What do you want to know?")
while True:
  query = input("")
  answer = qa.run(query)
  print(answer)
  print("\nWhat else do you want to know?")