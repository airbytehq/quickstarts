from setuptools import find_packages, setup

setup(
    name="postgres-to-mysql-migration",
    packages=find_packages(),
    install_requires=[
    ],
    extras_require={"dev": ["pytest"]},
)