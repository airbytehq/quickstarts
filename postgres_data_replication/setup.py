from setuptools import find_packages, setup

setup(
    name="postgres-data-replication",
    packages=find_packages(),
    install_requires=[
    ],
    extras_require={"dev": ["pytest"]},
)