import os
from dagster import OpExecutionContext
from dagster_dbt import DbtCliResource, dbt_assets
from dagster_airbyte import AirbyteResource, load_assets_from_airbyte_instance

from .constants import dbt_manifest_path

@dbt_assets(manifest=dbt_manifest_path)
def dbt_project_dbt_assets(context: OpExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()

airbyte_instance = AirbyteResource(
    host="localhost",
    port="8000",
    # If using basic auth, include username and password:
    username="airbyte",
    password=os.getenv("AIRBYTE_PASSWORD")
)

airbyte_assets = load_assets_from_airbyte_instance(airbyte_instance, key_prefix="faker")