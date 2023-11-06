# Airbyte-dbt-Snowflake-Looker Integration

Welcome to the "Airbyte-dbt-Snowflake-Looker Integration" repository! This repo provides a quickstart template for building a full data stack using Airbyte, Dagster, dbt, Snowflake and Looker. Easily extract data from Postgres and load it into Snowflake using Airbyte, and apply necessary transformations using dbt, all orchestrated seamlessly with Dagster. Then connect your Snowflake instance to Looker for business intelligence, analytics, data modeling, etc. While this template doesn't delve into specific data or transformations, its goal is to showcase the synergy of these tools.

This quickstart is designed to minimize setup hassles and propel you forward.

## Table of Contents

- [Airbyte-dbt-Snowflake-Looker Integration](#airbyte-dbt-snowflake-looker-integration)
  - [Table of Contents](#table-of-contents)
  - [Infrastructure Layout](#infrastructure-layout)
  - [Pipeline DAG](#pipeline-dag)
  - [Prerequisites](#prerequisites)
  - [1. Setting an environment for your project](#1-setting-an-environment-for-your-project)
  - [2. Setting Up Airbyte Connectors with Terraform](#2-setting-up-airbyte-connectors-with-terraform)
  - [3. Setting Up the dbt Project](#3-setting-up-the-dbt-project)
  - [4. Orchestrating with Dagster](#4-orchestrating-with-dagster)
  - [5. Integrating with Looker](#5-integrating-with-looker)
  - [Next Steps](#next-steps)

## Infrastructure Layout
![insfrastructure layout](images/adsl_stack.png)

## Pipeline DAG
![pipeline dag](images/dag.svg)

## Prerequisites

Before you embark on this integration, ensure you have the following set up and ready:

1. **Python 3.10 or later**: If not installed, download and install it from [Python's official website](https://www.python.org/downloads/).

2. **Docker and Docker Compose (Docker Desktop)**: Install [Docker](https://docs.docker.com/get-docker/) following the official documentation for your specific OS.

3. **Airbyte OSS version**: Deploy the open-source version of Airbyte. Follow the installation instructions from the [Airbyte Documentation](https://docs.airbyte.com/quickstart/deploy-airbyte/).

4. **Terraform**: Terraform will help you provision and manage the Airbyte resources. If you haven't installed it, follow the [official Terraform installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).


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
   git sparse-checkout add airbyte_dbt_dagster_snowflake
   ```

   
2. **Navigate to the directory**:  
   ```bash
   cd airbyte_dbt_dagster_snowflake
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

## 2. Setting Up Airbyte Connectors with Terraform

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

   Adjust the configurations in these files to suit your project's needs. Specifically, provide credentials for your Postgres and Snowflake connections. You can utilize the `variables.tf` file to manage these credentials.

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

   Once Terraform completes its tasks, navigate to the Airbyte UI. Here, you should see your source and destination connectors, as well as the connection between them, set up and ready to go.

## 3. Setting Up the dbt Project

[dbt (data build tool)](https://www.getdbt.com/) allows you to transform your data by writing, documenting, and executing SQL workflows. Setting up the dbt project requires specifying connection details for your data platform, in this case, Snowflake. Here’s a step-by-step guide to help you set this up:

1. **Navigate to the dbt Project Directory**:

   Change to the directory containing the dbt configuration:
   ```bash
   cd ../../dbt_project
   ```

2. **Update Connection Details**:

   You'll find a `profiles.yml` file within the directory. This file contains configurations for dbt to connect with your data platform. Update this file with your Snowflake connection details.

3. **Utilize Environment Variables (Optional but Recommended)**:

   To keep your credentials secure, you can leverage environment variables. An example is provided within the `profiles.yml` file.

4. **Test the Connection**:

   Once you’ve updated the connection details, you can test the connection to your Snowflake instance using:
   ```bash
   dbt debug
   ```

   If everything is set up correctly, this command should report a successful connection to Snowflake.

## 4. Orchestrating with Dagster

[Dagster](https://dagster.io/) is a modern data orchestrator designed to help you build, test, and monitor your data workflows. In this section, we'll walk you through setting up Dagster to oversee both the Airbyte and dbt workflows:

1. **Navigate to the Orchestration Directory**:

   Switch to the directory containing the Dagster orchestration configurations:
   ```bash
   cd ../../orchestration
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

   Here, you should see assets for both Airbyte and dbt. To get an overview of how these assets interrelate, click on "view global asset lineage". This will give you a clear picture of the data lineage, visualizing how data flows between the tools.

## 5. Integrating with Looker

Looker is a product that helps you explore, share, and visualize your company's data so that you can make better business decisions. It is an enterprise platform for BI, data applications, and embedded analytics that helps you explore and share insights in real time. It also has the ability to convert user input via a Graphical User Interface (GUI) into SQL queries and subsequently transmit them directly to the database in real-time. To get started with Looker and learn more about it, check [here](https://cloud.google.com/looker/docs).

Follow the steps below to integrate your Snowflake instance with your Looker studio.

1. Create a Looker User in Snowflake

   To allow Looker run queries in Snowflake, you need to create a dedicated user for the looker instance in Snowflake and provision access for the user. Run the queries below in Snowflake to do this.

   You can add in the `ON FUTURE` keyword to persist `GRANT` statements for future tables and objects in the database to prevent re-running the GRANT statements as new tables are created.

   ```sql
   -- change role to ACCOUNTADMIN
   use role ACCOUNTADMIN;

   -- create role for looker
   create role if not exists looker_role;
   grant role looker_role to role SYSADMIN;
      -- Note that we are not making the looker_role a SYSADMIN, but rather granting users with the SYSADMIN role to modify the looker_role
   
   -- create a user for looker
   create user if not exists looker_user
      password = '<enter password here>';

   grant role looker_role to user looker_user;

   alter user looker_user
      set default_role = looker_role
         default_warehouse = 'looker_wh';
   
   -- this part is to executed only if the user roles are to be changed  
   -- change role
   use role SYSADMIN;
   
   -- create a warehouse for looker (optional)
   create warehouse if not exists looker_wh
   
   -- set the size based on your dataset
   warehouse_size = medium
   warehouse_type = standard
   auto_suspend = 1800
   auto_resume = true
   initially_suspended = true;
   
   grant all privileges
      on warehouse looker_wh
      to role looker_role;

   -- grant read only database access (repeat for all database/schemas)
   grant usage on database <database> to role looker_role;
   grant usage on schema <database>.<schema> to role looker_role;

   -- rerun the following any time a table is added to the schema
   grant select on all tables in schema <database>.<schema> to role looker_role;
   -- or
   grant select on future tables in schema <database>.<schema> to role looker_role;

   -- create schema for looker to write back to
   use database <database>;
   create schema if not exists looker_scratch;
   use role ACCOUNTADMIN;
   grant ownership on schema looker_scratch to role SYSADMIN revoke current grants;
   grant all on schema looker_scratch to role looker_role;
   ```

2. Adding the Database Connection in Looker

   After creating the looker user in snowflake, we need to create a connection from Looker to Snowflake using our Snowflake credentials and the looker user we just created in Snowflake. To do this, follow the steps below.
   
   - Navigate to the **Admin** panel of the Looker interface.
   - Select **Connections**.
   - Click **Add Connection**. A Configuration Section will open up where you will be required to fill the connection details below. For more details see [here](https://cloud.google.com/looker/docs/connecting-to-your-db).

      - **Name**: Give the connection an Arbitrary name. 
      - **Dialect**: Select **Snowflake**.
      - **Host**: It is of the format <account_name>.snowflakecomputing.com. See [here](https://docs.snowflake.com/developer-guide/jdbc/jdbc-configure#connection-parameters) to validate your host value.
      - **Port**: The default is 443. 
      - **Database**: Provide the name of the default database that is required for use. Note that this field is case-sensitive.
      - **Schema**: This the default Database Schema that is used in your Snowflake Deployment.  
      - **Authentication**: Select **Database Account** or **OAuth**:
         - Use **Database Account** to specify the Username and Password of the Snowflake user account that will be used to connect to Looker.
         - Follow the steps below to get credentials to use **OAuth** for the connection.

            To set up an OAuth based connection, you will require a user account with `ACCOUNTADMIN` permission on Snowflake. Firstly you are required to run the following command in Snowflake, where `<looker_hostname>` is the hostname of the Looker Instance: 

            ```sql
            CREATE SECURITY INTEGRATION LOOKER
            TYPE = OAUTH
            ENABLED = TRUE
            OAUTH_CLIENT = LOOKER
            OAUTH_REDIRECT_URI = 'https://<looker_hostname>/external_oauth/redirect';
            ```

            To obtain the OAuth Client ID and Client Secret, you need to run the following command: 

            ```sql
            SELECT SYSTEM$SHOW_OAUTH_CLIENT_SECRETS('LOOKER');
            ```

            Paste in the OAUTH_CLIENT_ID and OAUTH_CLIENT_SECRET values in the Looker OAuth fields.

      - **Enable PDTs**: Use this to enable persistent derived tables (PDTs). See [here](https://cloud.google.com/looker/docs/derived-tables#persistent-derived-tables) for more information.
      - **Temp Database**: If PDTs [Persistent Derived Tables] are enabled, this section needs to be set to a Database Schema where the user has full privileges to create, drop, rename, and alter tables.
      - **(Optional) Max Connections per node**: See more about this [here](https://cloud.google.com/looker/docs/connecting-to-your-db#max_connections).
      - **Database Time Zone**: Default is UTC.
      - **Query Time Zone**: Default is UTC.
      - Additional JDBC parameters: Add additional JDBC parameters from the Snowflake JDBC driver.
         - Add `warehouse=<YOUR WAREHOUSE NAME>`.
         - Additionally, by default, Looker will set the following Snowflake parameters on each session:

            - `TIMESTAMP_TYPE_MAPPING=TIMESTAMP_LTZ`
            - `JDBC_TREAT_DECIMAL_AS_INT=FALSE`
            - `TIMESTAMP_INPUT_FORMAT=AUTO`
            - `AUTOCOMMIT=TRUE`
            
            You can override each of these parameters by setting an alternative value in the Additional JDBC parameters field, for example: `&AUTOCOMMIT=FALSE`

   - Click on **Test** to check if the connection is Successful. For troubleshooting, see [here](https://cloud.google.com/looker/docs/testing-db-connectivity).
   - Click **Connect** to save these settings.


Now that the connection to Snowflake has been created, you are good to go to explore your Snowflake data in Looker.
   


## Next Steps

Once you've set up and launched this initial integration, the real power lies in its adaptability and extensibility. Here’s a roadmap to help you customize and harness this project tailored to your specific data needs:

1. **Create dbt Sources for Airbyte Data**:

   Your raw data extracted via Airbyte can be represented as sources in dbt. Start by [creating new dbt sources](https://docs.getdbt.com/docs/build/sources) to represent this data, allowing for structured transformations down the line.

2. **Add Your dbt Transformations**:

   With your dbt sources in place, you can now build upon them. Add your custom SQL transformations in dbt, ensuring that you treat the sources as an upstream dependency. This ensures that your transformations work on the most up-to-date raw data.

3. **Execute the Pipeline in Dagster**:

   Navigate to the Dagster UI and click on "Materialize all". This triggers the entire pipeline, encompassing the extraction via Airbyte, transformations via dbt, and any other subsequent steps.

4. **Explore in Looker**:

   You can use the SQL Runner to create queries and Explores, create and share Looks (reports and dashboards), or use LookML to create a data model that Looker will use to query your data. However way you wish to go with your Snowflake data, the choice is yours.

5. **Extend the Project**:

   The real beauty of this integration is its extensibility. Whether you want to add more data sources, integrate additional tools, or enhance your transformation logic – the floor is yours. With the foundation set, sky's the limit for how you want to extend and refine your data processes.