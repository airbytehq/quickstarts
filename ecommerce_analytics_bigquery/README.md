# E-commerce Analytics Stack with Airbyte, dbt, Dagster and BigQuery

Below is a visual representation of how data flows through our integrated tools in this Quickstart. This comes from Dagster's global asset lineage view:

![Global Asset Lineage](./assets/Global_Asset_Lineage.svg)

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setting an environment for your project](#1-setting-an-environment-for-your-project)
- [Setting Up BigQuery to work with Airbyte and dbt](#2-setting-up-bigquery)
- [Setting Up Airbyte Connectors](#3-setting-up-airbyte-connectors)
- [Setting Up the dbt Project](#4-setting-up-the-dbt-project)
- [Orchestrating with Dagster](#5-orchestrating-with-dagster)
- [Next Steps](#next-steps)

## Prerequisites

Before you embark on this integration, ensure you have the following set up and ready:

1. **Python 3.10 or later**: If not installed, download and install it from [Python's official website](https://www.python.org/downloads/).

2. **Docker and Docker Compose (Docker Desktop)**: Install [Docker](https://docs.docker.com/get-docker/) following the official documentation for your specific OS.

3. **Airbyte OSS version**: Deploy the open-source version of Airbyte locally. Follow the installation instructions from the [Airbyte Documentation](https://docs.airbyte.com/quickstart/deploy-airbyte/).

4. **Terraform (Optional)**: Terraform will help you provision and manage the Airbyte resources. If you haven't installed it, follow the [official Terraform installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). This is an optional step because you can also create and manage Airbyte resources via the UI.

5. **Google Cloud account with BigQuery**: You will also need to add the necessary permissions to allow Airbyte and dbt to access the data in BigQuery. A step-by-step guide is provided [below](#2-setting-up-bigquery).

## 1. Setting an environment for your project

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
At this point you can view the code in your preferred IDE. For example, if you’re using Visual Studio Code, you can execute  `code .` to open the code. 

3. **Set Up a Virtual Environment**:  
You can use the following commands, just make sure to adapt to your specific python installation.

   - For Linux and Mac:
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

## 2. Setting Up BigQuery

#### 1. **Create a Google Cloud Project**
   - If you have a Google Cloud project, you can skip this step.
   - Go to the [Google Cloud Console](https://console.cloud.google.com/).
   - Click on the "Select a project" dropdown at the top right and select "New Project".
   - Give your project a name and follow the steps to create it.

#### 2. **Create BigQuery Datasets**
   - In the Google Cloud Console, go to BigQuery.
   - Make two new datasets: `raw_data` for Airbyte and `transformed_data` for dbt.
     - If you pick different names, remember to change the names in the code too.
   
   **How to create a dataset:**
   - In the left sidebar, click on your project name.
   - Click “Create Dataset”.
   - Enter the dataset ID (either `raw_data` or `transformed_data`).
   - Click "Create Dataset".

#### 3. **Create Service Accounts and Assign Roles**
   - Go to “IAM & Admin” > “Service accounts” in the Google Cloud Console.
   - Click “Create Service Account”.
   - Name your service account (like `airbyte-service-account`).
   - Assign the “BigQuery Data Editor” and “BigQuery Job User” roles to the service account.
   - Follow the same steps to make another service account for dbt (like `dbt-service-account`) and assign the roles.

   **How to create a service account and assign roles:**
   - While creating the service account, under the “Grant this service account access to project” section, click the “Role” dropdown.
   - Choose the “BigQuery Data Editor” and “BigQuery Job User” roles.
   - Finish the creation process.
   
#### 4. **Generate JSON Keys for Service Accounts**
   - For both service accounts, make a JSON key to let the service accounts sign in.
   
   **How to generate JSON key:**
   - Find the service account in the “Service accounts” list.
   - Click on the service account name.
   - In the “Keys” section, click “Add Key” and pick JSON.
   - The key will download automatically. Keep it safe and don’t share it.
   - Do this for the other service account too.

## 3. Setting Up Airbyte Connectors

To set up your Airbyte connectors, you can choose to do it via Terraform, or the UI. Choose one of the two following options.

### 3.1. Setting Up Airbyte Connectors with Terraform

Airbyte allows you to create connectors for sources and destinations via Terraform, facilitating data synchronization between various platforms. Here's how you can set this up:

1. **Navigate to the Airbyte Configuration Directory**:

   ```bash
   cd infra/airbyte
   ```

2. **Modify Configuration Files**:

   Within the `infra/airbyte` directory, you'll find three crucial Terraform files:
    - `provider.tf`: Defines the Airbyte provider.
    - `main.tf`: Contains the main configuration for creating Airbyte resources.
    - `variables.tf`: Holds various variables, including credentials.

   Adjust the configurations in these files to suit your project's needs: 

   - Provide credentials for your BigQuery connection in the `main.tf` file.
      - `dataset_id`: The name of the BigQuery dataset where Airbyte will load data. In this case, enter “raw_data”.
      - `project_id`: Your BigQuery project ID.
      - `credentials_json`: The contents of the service account JSON file. You should input a string, so you need to convert the JSON content to string beforehand.
      - `workspace_id`: Your Airbyte workspace ID, which can be found in the webapp url. For example, in this url: http://localhost:8000/workspaces/910ab70f-0a67-4d25-a983-999e99e1e395/ the workspace id would be `910ab70f-0a67-4d25-a983-999e99e1e395`.

   - Alternatively, you can utilize the `variables.tf` file to manage these credentials:
      - You’ll be prompted to enter the credentials when you execute `terraform plan` and `terraform apply`. If going for this option, just move to the next step. If you don’t want to use variables, remove them from the file.

3. **Initialize Terraform**:
   
   This step prepares Terraform to create the resources defined in your configuration files.
   ```bash
   terraform init
   ```

4. **Review the Plan**:

   Before applying any changes, review the plan to understand what Terraform will do.
   ```bash
   terraform plan
   ```

5. **Apply Configuration**:

   After reviewing and confirming the plan, apply the Terraform configurations to create the necessary Airbyte resources.
   ```bash
   terraform apply
   ```

6. **Verify in Airbyte UI**:

   Once Terraform completes its tasks, navigate to the [Airbyte UI](http://localhost:8000/). Here, you should see your source and destination connectors, as well as the connection between them, set up and ready to go 🎉.

### 3.2. Setting Up Airbyte Connectors Using the UI

Start by launching the Airbyte UI by going to http://localhost:8000/ in your browser. Then:

1. **Create a source**:

   - Go to the Sources tab and click on `+ New source`.
   - Search for “faker” using the search bar and select `Sample Data (Faker)`.
   - Adjust the Count and optional fields as needed for your use case. You can also leave as is. 
   - Click on `Set up source`.

2. **Create a destination**:

   - Go to the Destinations tab and click on `+ New destination`.
   - Search for “bigquery” using the search bar and select `BigQuery`.
   - Enter the connection details as needed.
   - For simplicity, you can use `Standard Inserts` as the loading method.
   - In the `Service Account Key JSON` field, enter the contents of the JSON file. Yes, the full JSON.
   - Click on `Set up destination`.

3. **Create a connection**:

   - Go to the Connections tab and click on `+ New connection`.
   - Select the source and destination you just created.
   - Enter the connection details as needed.
   - Click on `Set up connection`.

That’s it! Your connection is set up and ready to go! 🎉 

## 4. Setting Up the dbt Project

[dbt (data build tool)](https://www.getdbt.com/) allows you to transform your data by writing, documenting, and executing SQL workflows. Setting up the dbt project requires specifying connection details for your data platform, in this case, BigQuery. Here’s a step-by-step guide to help you set this up:

1. **Navigate to the dbt Project Directory**:

   Move to the directory containing the dbt configuration:
   ```bash
   cd ../../dbt_project
   ```

2. **Update Connection Details**:

   - You'll find a `profiles.yml` file within the directory. This file contains configurations for dbt to connect with your data platform. Update this file with your BigQuery connection details. Specifically, you need to update the Service Account JSON file path and your BigQuery project ID.
   - Provide your BigQuery project ID in the `database` field of the `dbt_project/models/sources/faker_sources.yml` file.

If you want to avoid hardcoding credentials in the `profiles.yml` file, you can leverage environment variables. An example of how to use them in this file is provided for the `keyfile` key.

3. **Test the Connection**:

   Once you’ve updated the connection details, you can test the connection to your BigQuery instance using:
   ```bash
   dbt debug
   ```
If everything is set up correctly, this command should report a successful connection to BigQuery 🎉.

## 5. Orchestrating with Dagster

[Dagster](https://dagster.io/) is a modern data orchestrator designed to help you build, test, and monitor your data workflows. In this section, we'll walk you through setting up Dagster to oversee both the Airbyte and dbt workflows:

1. **Navigate to the Orchestration Directory**:

   Switch to the directory containing the Dagster orchestration configurations:
   ```bash
   cd ../orchestration
   ```

2. **Set Environment Variables**:

   Dagster requires certain environment variables to be set to interact with other tools like dbt and Airbyte. Set the following variables:

   ```bash
   export DAGSTER_DBT_PARSE_PROJECT_ON_LOAD=1
   export AIRBYTE_PASSWORD=password
   ```
   
   Note: The `AIRBYTE_PASSWORD` is set to `password` as a default for local Airbyte instances. If you've changed this during your Airbyte setup, ensure you use the appropriate password here.

3. **Launch the Dagster UI**:

   With the environment variables in place, kick-start the Dagster UI:
   ```bash
   dagster dev
   ```

4. **Access Dagster in Your Browser**:

   Open your browser and navigate to:
   ```
   http://127.0.0.1:3000
   ```
Here, you should see assets for both Airbyte and dbt. To get an overview of how these assets interrelate, click on `view global asset lineage` at the top right corner of the Dagster UI. This will give you a clear picture of the data lineage, visualizing how data flows between the tools.

5. **Materialize Dagster Assets**:

   In the Dagster UI, click on `Materialize all`. This should trigger the full pipeline. First the Airbyte sync to extract data from Faker and load it into BigQuery, and then dbt to transform the raw data, materializing the `staging` and `marts` models.

You can go to the Airbyte UI and confirm a sync is running, and then, once the dbt jobs have run, go to your BigQuery console and check the views have been created in the `transformed data` dataset.

## Next Steps

Congratulations on deploying and running the E-commerce Analytics Quistart! 🎉 Here are some suggestions on what you can explore next to dive deeper and get more out of your project:

### 1. **Explore the Data and Insights**
   - Dive into the datasets in BigQuery, run some queries, and explore the data you've collected and transformed. This is your chance to uncover insights and understand the data better!

### 2. **Optimize Your dbt Models**
   - Review the transformations you’ve applied using dbt. Try optimizing the models or create new ones based on your evolving needs and insights you want to extract.

### 3. **Expand Your Data Sources**
   - Add more data sources to Airbyte. Explore different types of sources available, and see how they can enrich your existing datasets and broaden your analytical capabilities.

### 4. **Enhance Data Quality and Testing**
   - Implement data quality tests in dbt to ensure the reliability and accuracy of your transformations. Use dbt's testing features to validate your data and catch issues early on.

### 5. **Automate and Monitor Your Pipelines**
   - Explore more advanced Dagster configurations and setups to automate your pipelines further and set up monitoring and alerting to be informed of any issues immediately.

### 6. **Scale Your Setup**
   - Consider scaling your setup to handle more data, more sources, and more transformations. Optimize your configurations and resources to ensure smooth and efficient processing of larger datasets.

### 7. **Contribute to the Community**
   - Share your learnings, optimizations, and new configurations with the community. Contribute to the respective tool’s communities and help others learn and grow.

