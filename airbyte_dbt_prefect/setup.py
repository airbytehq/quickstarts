from setuptools import find_packages, setup

setup(
    name="orchestration",
    version="0.0.1",
    packages=find_packages(),
    install_requires=[
        "prefect",
        "dbt_prefect",  # Add this line for dbt-Prefect integration
        # Other dependencies as needed
    ],
)
