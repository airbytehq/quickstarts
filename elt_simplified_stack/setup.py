from setuptools import find_packages, setup

setup(
    name="elt-simplified"
    packages=find_packages(),
    install_requires=[
        "prefect",
        "prefect-airbyte",
        "prefect-dbt",
        "dbt-core>=1.4.0",
        "dbt-bigquery",
    ],
    extras_require={"dev": ["pytest"]},
)
