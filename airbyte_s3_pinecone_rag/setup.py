from setuptools import find_packages, setup

setup(
    name="pyairbyte_s3_pinecone_rag",
    packages=find_packages(),
    install_requires=[
        "dbt-bigquery",
        "pinecone-client",
        "langchain",
        "openai==0.28.1",
        "tiktoken",
        "rich"
    ],
    extras_require={"dev": ["pytest"]},
)
