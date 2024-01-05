import os

from prefect import flow, task

from prefect_airbyte.server import AirbyteServer
from prefect_airbyte.connections import AirbyteConnection, AirbyteSyncResult
from prefect_airbyte.flows import run_connection_sync

from prefect_dbt.cli.commands import DbtCoreOperation



remote_airbyte_server = AirbyteServer(
    username="airbyte",
    password=os.getenv("AIRBYTE_PASSWORD"),
    server_host="localhost",
    server_port="8000"
)

remote_airbyte_server.save("my-remote-airbyte-server", overwrite=True)

airbyte_connection = AirbyteConnection(
    airbyte_server=remote_airbyte_server,
    connection_id="...my_airbyte_connection_id...", # Replace the value with your Airbyte connection ID
    status_updates=True,
)

@task(name="Extract, Load with Airbyte")
def run_airbyte_sync(connection: AirbyteConnection) -> AirbyteSyncResult:
    job_run = connection.trigger()
    job_run.wait_for_completion()
    return job_run.fetch_result()

def run_dbt_commands(commands, prev_task_result):
    dbt_task = DbtCoreOperation(
        commands=commands,
        project_dir="../dbt_project",
        profiles_dir="../dbt_project",
        wait_for=prev_task_result
    )
    return dbt_task

@flow(log_prints=True)
def my_elt_flow():
    
    # run Airbyte sync
    airbyte_sync_result = run_airbyte_sync(airbyte_connection)

    # run dbt precheck    
    dbt_init_task = task(name="dbt Precheck")(run_dbt_commands)(
        commands=["pwd", "dbt debug", "dbt list"], 
        prev_task_result=airbyte_sync_result
        )
    dbt_init_task.run()

    # run dbt models
    dbt_run_task = task(name="Transform with dbt")(run_dbt_commands)(
        commands=["dbt run"], 
        prev_task_result=dbt_init_task
        )
    dbt_run_task.run()
    


if __name__ == "__main__":
    my_elt_flow()
