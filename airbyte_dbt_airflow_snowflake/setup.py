from setuptools import find_packages, setup

setup(
    name="airbyte-dbt-airflow-snowflake",
    packages=find_packages(),
    install_requires=[
        "dbt-snowflake",
        "apache-airflow[airbyte]",
        "apache-airflow",
    ],
    extras_require={"dev": ["pytest"]},
)