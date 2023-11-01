// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_weatherstack" "my_source_weatherstack" {
  configuration = {
    credentials = {
      source_weatherstack_authentication_access_key = {
        access_key = var.access_key

      }

    }


    query = var.query

    historical_date = "2023-09-28"

  }
  name         = "Weatherstack"
  workspace_id = var.workspace_id
}

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
  configuration = {
    dataset_id       = var.dataset_id
    dataset_location = "US"
    destination_type = "bigquery"
    project_id       = var.project_id
    credentials_json = var.credentials_json
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
resource "airbyte_connection" "weatherstack_bigquery" {
  name           = "Weatherstack to BigQuery"
  source_id      = airbyte_source_weatherstack.my_source_weatherstack.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "current_weather"
      }
    ]
  }
}