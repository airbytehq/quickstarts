# ELT simplified Stack With Github, Airbyte, DBT, Prefect and BigQuery

Welcome to the "ELT simplified Stack" repository! ✨ For extracting from source - and travel towards destination with some intermediate transformations with Airbyte - Github, DBT, BigQuery, and Prefect. With this setup, you can pull Github data, extract it using Airbyte, put it into BigQuery, and play around with it using dbt and Prefect.

This Quickstart is all about making things easy, getting you started quickly and showing you how smoothly all these tools can work together!

## Table of Contents

- [Infrastructure Layout](#infrastructure-layout)
- [Prerequisites](#prerequisites)
- [Setting an environment for your project](#1-setting-an-environment-for-your-project)
- [Setting Up BigQuery to work with Airbyte and dbt](#2-setting-up-bigquery)
- [Setting Up Airbyte Connectors with Terraform](#3-setting-up-airbyte-connectors-with-terraform)
- [Setting Up the dbt Project](#4-setting-up-the-dbt-project)
- [Orchestrating with Prefect](#5-orchestrating-with-prefect)
- [Next Steps](#next-steps)

## Infrastructure Layout
![insfrastructure layout](images/infrastructure.png)

## Prerequisites

Before you embark on this integration, ensure you have the following set up and ready:

1. **Python 3.10 or later**: If not installed, download and install it from [Python's official website](https://www.python.org/downloads/).

2. **Docker and Docker Compose (Docker Desktop)**: Install [Docker](https://docs.docker.com/get-docker/) following the official documentation for your specific OS.

3. **Airbyte OSS version**: Deploy the open-source version of Airbyte. Follow the installation instructions from the [Airbyte Documentation](https://docs.airbyte.com/quickstart/deploy-airbyte/).

4. **Terraform**: Terraform will help you provision and manage the Airbyte resources. If you haven't installed it, follow the [official Terraform installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

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
   git sparse-checkout add elt_simplified
   ```

2. **Navigate to the directory**:

   ```bash
   cd elt_simplified
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

## 3. Setting Up Airbyte Connectors with Terraform

Airbyte allows you to create connectors for sources and destinations, facilitating data synchronization between various platforms. In this project, we're harnessing the power of Terraform to automate the creation of these connectors and the connections between them. Here's how you can set this up:

1. **Navigate to the Airbyte Configuration Directory**:

   Change to the relevant directory containing the Terraform configuration for Airbyte:

   ```bash
   cd infra/airbyte
   ```

2. **Modify Configuration Files**:

   Within the `infra/airbyte` directory, you'll find three crucial Terraform files:

   - `provider.tf`: Defines the Airbyte provider.
   - `main.tf`: Contains the main configuration for creating Airbyte resources.
   - `variables.tf`: Holds various variables, including credentials.

   Adjust the configurations in these files to suit your project's needs. Specifically, provide credentials for your BigQuery connection. You can utilize the `variables.tf` file to manage these credentials.

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

   Once Terraform completes its tasks, navigate to the [Airbyte UI](http://localhost:8000/). Here, you should see your source and destination connectors, as well as the connection between them, set up and ready to go.

## 4. Setting Up the dbt Project

[dbt (data build tool)](https://www.getdbt.com/) allows you to transform your data by writing, documenting, and executing SQL workflows. Setting up the dbt project requires specifying connection details for your data platform, in this case, BigQuery. Here’s a step-by-step guide to help you set this up:

1. **Navigate to the dbt Project Directory**:

   Change to the directory containing the dbt configuration:

   ```bash
   cd dbt_project
   ```

2. **Update Connection Details**:

   You'll find a `profiles.yml` file within the directory. This file contains configurations for dbt to connect with your data platform. Update this file with your BigQuery connection details.

3. **Utilize Environment Variables (Optional but Recommended)**:

   To keep your credentials secure, you can leverage environment variables. An example is provided within the `profiles.yml` file.

4. **Test the Connection**:

   Once you’ve updated the connection details, you can test the connection to your BigQuery instance using:

   ```bash
   dbt debug
   ```

   If everything is set up correctly, this command should report a successful connection to BigQuery.

5. **Run the Models**:

   If you would like to run the dbt models manually at this point, you can do so by executing:

   ```bash
   dbt run
   ```

   You can verify the data has been transformed by going to BigQuery and checking the `transformed_data` dataset.

## 5. Orchestrating with Prefect

[Prefect](https://prefect.io/) is an orchestration workflow tool that makes it easy to build, run, and monitor data workflows by writing Python code. In this section, we'll walk you through creating a Prefect flow to orchestrate both Airbyte extract and load operations, and dbt transformations with Python:

1. **Navigate to the Orchestration Directory**:

   Switch to the directory containing the Prefect orchestration configurations:
   ```bash
   cd ../orchestration
   ```

2. **Set Environment Variables**:

   Prefect requires certain environment variables to be set to interact with other tools like dbt and Airbyte. Set the following variables:

   ```bash
   export AIRBYTE_PASSWORD=password
   ```

3. **Connect to Prefect's API**:

   Open a new terminal window. Start a local Prefect server instance in your virtual environment:

   ```bash
   prefect server start
   ```

4. **Deploy the Flow**:

   When we run the flow script, Prefect will automatically create a flow deployment that you can interact with via the UI and API. The script will stay running so that it can listen for scheduled or triggered runs of this flow; once a run is found, it will be executed within a subprocess.

   ```bash
   python my_elt_flow.py
   ```

5. **Access Prefect UI in Your Browser**:

   Open your browser and navigate to:
   ```
   http://127.0.0.1:4200
   ```
   You can now begin interacting with your newly created deployment!

## Next Steps

Congratulations on deploying and running the elt_simplified quickstart! 🎉 Here are some suggestions on what you can explore next to dive deeper and get more out of your project:

### 1. **Explore the Data and Insights**
   - Your raw data extracted via Airbyte can be represented as sources in dbt. Start by [creating new dbt sources](https://docs.getdbt.com/docs/build/sources) to represent this data, allowing for structured transformations down the line.

### 2. **Optimize Your dbt Models**
   - Review the transformations you’ve applied using dbt. Try optimizing the models or create new ones based on your evolving needs and insights you want to extract.

### 3. **Extend the Prefect Pipeline**:

    - You can create flow runs from this deployment via API calls to be triggered by new data sync in Airbyte rather than on a schedule. You can customize your dbt   runs based on the results got from AirbyteSyncResult. You can also migrate the deployment to the Prefect cloud.

### 4. **Extend the Project**:

    - The real beauty of this integration is its extensibility. Whether you want to add more data sources, integrate additional tools, or enhance your transformation logic – the floor is yours. With the foundation set, sky's the limit for how you want to extend and refine your data processes.
