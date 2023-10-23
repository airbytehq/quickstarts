from setuptools import find_packages, setup

setup(
    name="airbyte-dbt-prefect-snowflake",
    packages=find_packages(),
    install_requires=[
        "dbt-snowflake",
        "prefect",
        "prefect-airbyte",
        "prefect-dbt",
        "dbt-core>=1.4.0",
    ],
    extras_require={"dev": ["pytest"]},
)
