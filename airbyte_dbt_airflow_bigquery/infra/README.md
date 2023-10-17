# Airbyte setup with terraform

This folder contains the terraform code to setup a source, destination and connection in Airbyte using terraform.

We're using the [airbyte official provider](https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs), and any details can be found in the documentation.

For this example we're using:
- [Airbyte Source Faker](https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/source_faker)
- [Airbyte Destination BigQuery](https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/destination_bigquery)
- [Airbyte Connection](https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/connection)

This is all optional, since part of the advantage of using Airbyte is setting up the sources and destinations via the UI. However, if you want to automate this process, you can use this terraform code as a starting point.