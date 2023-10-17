from pendulum import datetime

from airflow.decorators import dag, task
from airflow.datasets import Dataset
from airflow.models import Variable
from airflow.models.param import Param

from cosmos.operators import DbtDocsOperator

from dbt_config import project_config, profile_config  # type:ignore
from dbt_upload_docs import upload_docs  # type:ignore


@dag(
    dag_id="render_dbt_docs",
    start_date=datetime(2023, 10, 1),
    schedule="@daily",
    tags=["dbt", "docs"],
    catchup=False,
)
def render_dbt_docs():
    """
    ## render_dbt_docs dag
    Generates dbt docs files and makes them available.
    """
    render_docs = DbtDocsOperator(
        task_id="render_dbt_docs",
        profile_config=profile_config,
        project_dir="/opt/airflow/dbt_project",
        callback=upload_docs,
    )
    #
    render_docs

render_dbt_docs()