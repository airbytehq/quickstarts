from setuptools import find_packages, setup

setup(
    name="api-to-warehouse",
    packages=find_packages(),
    install_requires=[
    ],
    extras_require={"dev": ["pytest"]},
)