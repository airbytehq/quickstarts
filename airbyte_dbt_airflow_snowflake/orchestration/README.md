# Airflow setup with Airbyte and DBT

This folder contains the code to setup Airflow with Airbyte and DBT.

## Setup

We're using the [Running Airflow in Docker](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html) as a starting point.

We've downloaded the official `docker-compose.yaml` file provided by Airflow and adapted it to:
- Use some configurations from an .env file
- Add the Airbyte operator
- Mount our dbt project folder into the container image
- For running locally, we've set up the network to use the one deployed by the Airbyte container setup (from [Airbyte Local Deployment](https://docs.airbyte.com/deploying-airbyte/local-deployment))
