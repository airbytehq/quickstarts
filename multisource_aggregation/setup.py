from setuptools import find_packages, setup

setup(
    name="multisource-database-aggregation",
    packages=find_packages(),
    install_requires=[
        "dbt-bigquery",
        "dagster",
        "dagster-cloud",
        "dagster-dbt",
        "dagster-airbyte",
    ],
    extras_require={"dev": ["dagit", "pytest"]},
)