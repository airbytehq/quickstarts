// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_faker" "faker" {
  configuration = {
    always_updated    = false
    count             = 1000
    parallelism       = 9
    records_per_slice = 10
    seed              = 6
    source_type       = "faker"
  }
  name         = "Faker"
  workspace_id = var.workspace_id
}

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
  configuration = {
    dataset_id       = var.dataset_id
    dataset_location = "US"
    destination_type = "bigquery"
    project_id       = var.project_id
    credentials_json = file(var.credentials_json_path)
    loading_method = {
      destination_bigquery_loading_method_standard_inserts = {
        method = "Standard"
      }
    }
  }
  name         = "BigQuery"
  workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "faker_to_bigquery" {
  name           = "Faker to BigQuery"
  source_id      = airbyte_source_faker.faker.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "users"
      },
      {
        name = "products"
      },
      {
        name = "purchases"
      },
    ]
  }
}
