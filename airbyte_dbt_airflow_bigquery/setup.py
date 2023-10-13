from setuptools import find_packages, setup

setup(
    name="airbyte-dbt-airflow-bigquery",
    packages=find_packages(),
    install_requires=[
        "dbt-bigquery",
        "astronomer-cosmos[dbt-bigquery]",
        "apache-airflow-providers-google",
        "apache-airflow-providers-airbyte",
        "apache-airflow",
        "airflow-providers-google",
    ],
    extras_require={"dev": ["pytest"]},
)


