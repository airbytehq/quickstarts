import os
from prefect import Flow, task, Parameter
from prefect.run_configs.local import LocalRun
from prefect.storage.local import Local
from prefect_dbtdk.tasks import DbtCloudRunTask, AirbyteTask

from .constants import dbt_manifest_path

@task
def dbt_project_dbt_assets():
    return "Run your dbt tasks here using Prefect tasks."

@task
def define_flow():
    dbt_run_task = DbtCloudRunTask(
        project_id="YOUR_PROJECT_ID",  # Replace with your dbt Cloud project ID
        api_token="YOUR_API_TOKEN",    # Replace with your dbt Cloud API token
        job_name="YOUR_JOB_NAME"       # Replace with your dbt Cloud job name
    )

    result = dbt_run_task.run()
    return result

airbyte_instance = AirbyteTask(
    host="localhost",
    port="8000",
    # If using basic auth, include username and password:
    username="airbyte",
    password=os.getenv("AIRBYTE_PASSWORD")
)