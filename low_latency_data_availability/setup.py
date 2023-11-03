from setuptools import find_packages, setup

setup(
    name="low-latency-data-availability",
    packages=find_packages(),
    install_requires=[
    ],
    extras_require={"dev": ["pytest"]},
)