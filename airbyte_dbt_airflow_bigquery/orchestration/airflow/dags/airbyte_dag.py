from pendulum import datetime

from airflow.decorators import dag, task
from airflow.datasets import Dataset
from airflow.models import Variable
from airflow.models.param import Param

from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator

ECOMMERCE = Dataset("airbyte_ecommerce_bigquery")


@dag(
    dag_id="trigger_airbyte_faker",
    start_date=datetime(2023, 10, 1),
    schedule="@daily",
    tags=["airbyte"],
    catchup=False,
)
def faker_to_bigquery():
    """
    ## trigger_airbyte_faker dag
    Runs the connection "Faker to BigQuery" on Airbyte.

    """
    extract_data = AirbyteTriggerSyncOperator(
        task_id="airbyte_faker_bigquery_example",
        airbyte_conn_id="airbyte_connection",
        connection_id="",
        asynchronous=False,
        timeout=3600,
        wait_seconds=3,
        outlets=[ECOMMERCE],
    )
    extract_data


faker_to_bigquery()

from cosmos import DbtDag
from cosmos.config import RenderConfig

from dbt_config import project_config, profile_config  # type:ignore


dbt_cosmos_dag = DbtDag(
    dag_id="dbt__ecommerce",
    start_date=datetime(2023, 10, 1),
    schedule=[ECOMMERCE],
    tags=["dbt", "example", "airbyte", "ecommerce"],
    catchup=False,
    project_config=project_config,
    profile_config=profile_config,
    render_config=RenderConfig(select=["path:models/ecommerce"]),
)

dbt_cosmos_dag
