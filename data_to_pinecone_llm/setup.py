from setuptools import find_packages, setup

setup(
    name="data_to_pinecone_llm",
    packages=find_packages(),
    install_requires=[
        "dbt-bigquery",
        "dagster",
        "dagster-cloud",
        "dagster-dbt",
        "dagster-airbyte",
        "pinecone-client",
        "langchain",
        "openai==0.28.1",
        "tiktoken",
        "rich"
    ],
    extras_require={"dev": ["dagit", "pytest"]},
)
