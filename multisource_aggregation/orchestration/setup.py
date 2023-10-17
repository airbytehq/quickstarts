from setuptools import find_packages, setup

setup(
    name="orchestration",
    version="0.0.1",
    packages=find_packages(),
    install_requires=[
        "dagster",
        "dagster-cloud",
        "dagster-dbt",
        "dbt-core>=1.4.0",
        "dbt-bigquery",
    ],
    extras_require={
        "dev": [
            "dagster-webserver",
        ]
    },
)