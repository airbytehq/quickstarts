from setuptools import find_packages, setup

setup(
    name="airbyte-dbt-prefect-bigquery",
    packages=find_packages(),
    install_requires=[
        "prefect",
        "prefect-airbyte",
        "prefect-dbt",
        "dbt-bigquery",
    ],
    extras_require={"dev": ["pytest"]},
)