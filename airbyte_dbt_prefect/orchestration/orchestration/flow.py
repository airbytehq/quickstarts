from prefect import Flow

from .assets import dbt_project_dbt_assets, airbyte_assets, define_flow

with Flow("my-flow") as flow:
    dbt_assets = dbt_project_dbt_assets()
    airbyte_assets = airbyte_assets()
    dbt_run_result = define_flow()

dbt_assets.set_upstream(airbyte_assets)
