# Airbyte, dbt, Snowflake, and Looker (ADSL) Stack 

Welcome to the "Airbyte, dbt, Snowflake, and Looker (ADSL) Stack " repository! 

This folder in the repo provides you with a quickstart template for building a full data stack using Airbyte, dbt, Snowflake, and Looker Stack.

For this project, we will extract data from GitHub using Airbyte, and load it into Snowflake, while applying the data transformation step using dbt. After that, we would visualize the data in Looker. While this template might not dive into specific data or transformations, its goal is to showcase the synergy of these tools.

This quickstart is designed to minimize setup hassles and propel you forward.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setting an environment for your project](#1-setting-an-environment-for-your-project)
- [Getting Data from GitHub](#2-getting-data-from-github)
- [Setting Up Snowflakes](#3-setting-up-snowflakes)
- [Setting Up the dbt Project](#4-setting-up-the-dbt-project)

## Prerequisites

Before you embark on this integration, ensure you have the following set up and ready:

1. **Python 3.10 or later**: If not installed, download and install it from [Python's official website](https://www.python.org/downloads/).

2. **Docker and Docker Compose (Docker Desktop)**: Install [Docker](https://docs.docker.com/get-docker/) following the official documentation for your specific OS.

3. **Airbyte OSS version**: Deploy the open-source version of Airbyte. Follow the installation instructions from the [Airbyte Documentation](https://docs.airbyte.com/quickstart/deploy-airbyte/).

4. GitHub account: You will need it to get your GitHub key. A step-by-step guide is provided [here]((#2-Getting-Data-from-GitHub)

5. Snowflakes: You will also need to add the necessary permissions to allow Airbyte and dbt to access the data in Snowflakes. A step-by-step guide is provided [below](#3-setting-up-snowflakes).

# 1. Setting an environment for your project

Get the project up and running on your local machine by following these steps:

1. **Clone the repository (Clone only this quickstart)**:  
   ```bash
   git clone --filter=blob:none --sparse  https://github.com/airbytehq/quickstarts.git
   ```

   ```bash
   cd quickstarts
   ```

   ```bash
   git sparse-checkout add ecommerce_analytics_bigquery
   ```


2. **Navigate to the directory**:  
   ```bash
   cd ecommerce_analytics_bigquery
   ```

3. **Set Up a Virtual Environment**:  
   - For Mac:
     ```bash
     python3 -m venv venv
     source venv/bin/activate
     ```
   - For Windows:
     ```bash
     python -m venv venv
     .\venv\Scripts\activate
     ```

4. **Install Dependencies**:  
   ```bash
   pip install -e ".[dev]"
   ```

# 2. Getting Data from GitHub

# 3. Setting up Snowflakes

# 4. Setting up the dbt Project
