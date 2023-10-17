# Airflow setup with Airbyte and DBT

This folder contains the code to setup Airflow with Airbyte and DBT.

## Setup

We're using the [Running Airflow in Docker](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html) as a starting point.

We've downloaded the official `docker-compose.yaml` file provided by Airflow and adapted it to:
- Use some configurations from an .env file
- Add the Airbyte operator, dbt and astronomer-cosmos packages
- Mount our dbt project folder into the container image
- For running locally, we've set up the network to use the one deployed by the Airbyte container setup (from [Airbyte Local Deployment](https://docs.airbyte.com/deploying-airbyte/local-deployment))
- Admitting you're

## Features

- Providing dbt docs as a plugin from airflow, and making it available in the UI (and behing authentication)
- Example dag with the airbyte operator
- Example dag rendering dbt docs
- Example dag orchestrating specific dbt-models inside a dag with multiple tasks
- Example dag orchestrating specific dbt models as a dag

We're also using dataset aware schedules, and the airflow decorator to write the dag code.