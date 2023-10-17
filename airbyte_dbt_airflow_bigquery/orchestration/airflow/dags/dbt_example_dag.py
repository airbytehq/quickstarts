from pendulum import datetime

from airflow.decorators import dag
from airflow.datasets import Dataset
from airflow.models import Variable
from airflow.models.param import Param

from cosmos import DbtTaskGroup
from cosmos.operators import DbtDocsOperator
from cosmos.config import RenderConfig

from dbt_config import project_config, profile_config  # type:ignore
from dbt_upload_docs import upload_docs  # type:ignore


@dag(
    dag_id="dbt__jaffle-shop",
    start_date=datetime(2023, 10, 1),
    schedule="@daily",
    tags=["dbt", "example", "jaffle-shop"],
    catchup=False,
)
def dbt_jaffle_shop_dag():
    """
    ## dbt__jaffle-shop dag
    It runs the dbt models in the staging environment (models/example/staging) and then update the docs page.
    """
    dbt_task_group = DbtTaskGroup(
        group_id="dbt_example",
        project_config=project_config,
        profile_config=profile_config,
        render_config=RenderConfig(
            select=["path:models/example/staging", "path:models/example/production"]
        ),
    )
    render_dbt_docs = DbtDocsOperator(
        task_id="render_dbt_docs",
        profile_config=profile_config,
        project_dir="/opt/airflow/dbt_project",
        callback=upload_docs,
    )
    dbt_task_group >> render_dbt_docs
    #


@dag(
    dag_id="dbt__example",
    start_date=datetime(2023, 10, 1),
    schedule="@daily",
    tags=["dbt", "example"],
    catchup=False,
)
def dbt_example_dag():
    """
    ## dbt__example dag
    It runs the dbt models that are not in the staging or production environment in models/example and then update the docs page.
    """
    dbt_task_group = DbtTaskGroup(
        group_id="dbt_example",
        project_config=project_config,
        profile_config=profile_config,
        render_config=RenderConfig(
            exclude=["path:models/example/staging", "path:models/example/production","path:models/ecommerce"]
        ),
    )
    render_dbt_docs = DbtDocsOperator(
        task_id="render_dbt_docs",
        profile_config=profile_config,
        project_dir="/opt/airflow/dbt_project",
        callback=upload_docs,
    )
    dbt_task_group >> render_dbt_docs
    #


# Run dag
dbt_jaffle_shop_dag()
dbt_example_dag()
