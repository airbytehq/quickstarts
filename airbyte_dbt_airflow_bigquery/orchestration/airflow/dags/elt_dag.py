from pendulum import datetime
from airflow.decorators import dag
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator

from cosmos import DbtDag
from cosmos.operators import DbtDocsOperator
from cosmos.config import RenderConfig

from dbt_config import project_config, profile_config  # type:ignore
from dbt_upload_docs import upload_docs  # type:ignore

# Define the ELT DAG
@dag(
    dag_id="elt_dag",
    start_date=datetime(2023, 10, 1),
    schedule="@daily",
    tags=["airbyte", "dbt", "bigquery", "ecommerce"],
    catchup=False,
)
def extract_and_transform():
    """
    Runs the connection "Faker to BigQuery" on Airbyte and then triggers the dbt DAG.
    """
    # Airbyte sync task
    extract_data = AirbyteTriggerSyncOperator(
        task_id="trigger_airbyte_faker_to_bigquery",
        airbyte_conn_id="airbyte_connection",
        connection_id="your_connection_id", # Update with your Airbyte connection ID
        asynchronous=False,
        timeout=3600,
        wait_seconds=3
    )

    # Trigger for dbt DAG
    trigger_dbt_dag = TriggerDagRunOperator(
        task_id="trigger_dbt_dag",
        trigger_dag_id="dbt_ecommerce",
        wait_for_completion=True,
        poke_interval=30,
    )

    render_dbt_docs = DbtDocsOperator(
        task_id="render_dbt_docs",
        profile_config=profile_config,
        project_dir="/opt/airflow/dbt_project",
        callback=upload_docs,
    )

    # Set the order of tasks
    extract_data >> trigger_dbt_dag >> render_dbt_docs

# Instantiate the ELT DAG
extract_and_transform_dag = extract_and_transform()

# Define the dbt DAG using DbtDag from the cosmos library
dbt_cosmos_dag = DbtDag(
    dag_id="dbt_ecommerce",
    start_date=datetime(2023, 10, 1),
    tags=["dbt", "ecommerce"],
    catchup=False,
    project_config=project_config,
    profile_config=profile_config,
    render_config=RenderConfig(select=["path:models/ecommerce"]),
)

# Instantiate the dbt DAG
dbt_cosmos_dag
