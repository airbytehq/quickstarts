// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs


// Sources
resource "airbyte_source_datadog" "my_source_datadog" {
  configuration = {
    source_type = "datadog"
    credentials = {
      source_datadog_authentication_api_key = {
        api_key = var.datadog_api_key
      }
    }
    start_date = "2020-10-15T00:00:00Z"
  }
  name         = "Datadog Metrics and Logs"
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
resource "airbyte_connection" "datadog_bigquery" {
  name           = "Datadog to BigQuery"
  source_id      = airbyte_source_datadog.my_source_datadog.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "logs"
      },
      {
        name = "metrics"
      },
      // Add other Datadog streams you are interested in
    ]
  }
}