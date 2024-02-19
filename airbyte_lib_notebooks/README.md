# PyAirbyte Notebooks Quickstart

This quickstart will help you get started quickly with PyAirbyte.

> **Note:** **PyAirbyte is currently in private beta and is not intended for production use.**

## Quickstart Quicklinks

To jump right in, click on any of the below links to open a new Colab notebook from the provided quickstart template.

1. [Basic Features Demo](https://colab.research.google.com/github/airbytehq/quickstarts/blob/master/airbyte_lib_notebooks/AirbyteLib_Basic_Features_Demo.ipynb) - Walks through the basic functionality of PyAirbyte and how to use it in a Notebook environment.
2. [CoinAPI Demo](https://colab.research.google.com/github/airbytehq/quickstarts/blob/master/airbyte_lib_notebooks/AirbyteLib_CoinAPI_Demo.ipynb) - Shows how to provide credentials securely and perform basic graphing.
3. [GitHub Demo](https://colab.research.google.com/github/airbytehq/quickstarts/blob/master/airbyte_lib_notebooks/AirbyteLib_Github_Incremental_Demo.ipynb) - Demonstrates how to get data from GitHub, how to analyze GitHub metrics and how to refresh your cache data incrementally.
4. [GA4 Demo](https://colab.research.google.com/github/airbytehq/quickstarts/blob/master/airbyte_lib_notebooks/AirbyteLib_GA4_Demo.ipynb) - A Google Analytics demo showing how to analyze page views and other GA metrics.

## How to use these Quickstarts

There are three ways to use the quickstart resources here.

### Google Colab

Google Colab ("Colab" for short) is a hosted version of Jupyter. Because it is hosted by google, most people can access Colab using their existing Google account. To use these notebooks in Colab, click on the "Open in Colab" badge at the top of the file.

Note:

- Colab doesn't come with virtual environment ("venv") support by default. For this reason, our demo workbooks start by installing venv support as a prerequisite, using `apt-get`.

### Self-Hosted Jupyter

If you have a self-hosted Jupyter instance, you can load any of the notebooks in this directory.

### VS Code Notebooks

You can run these notebooks natively in VS Code if you have the Python extension installed. You can also use GitHub Codespaces to open a new VS Code devcontainer in your web browser.

## Securely Managed Secrets

You can pass secrets to PyAirbyte by using the `get_secret()` function. This call will retrieve a named secret from any of the following locations:

1. Google Colab Secrets
2. Environment Variables
3. Masked User Input (via [getpass](https://docs.python.org/3/library/getpass.html))

If you are using Google Colab, we suggest using the Colab secrets feature. For other environments, you can set your secret values in environment variables.

Note: The `get_secret()` implementation in PyAirbyte is provided for your convenience as a secure runtime-agnostic default secrets interface. You are always free to use any secrets management platform you are most familiar with.

**Warning:** Please do not enter your secrets directly into notebook cells. Doing so can cause the secret to be leaked into logs and/or in the "previous versions" look-back of the notebook. Instead, simply call `get_secret()` without pre-initializing the value. If the value is not already initialized, you will be prompted for secret values interactively and all values will be masked during input to avoid accidental leakage. This is performed using the Python standard library [`getpass`](https://docs.python.org/3/library/getpass.html).
