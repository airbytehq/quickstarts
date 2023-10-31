// Source
resource "airbyte_source_recreation" "my_source_recreation" {
  configuration = {
    apikey      = var.api_key
    source_type = "recreation"
  }
  name         = "Recreation"
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
resource "airbyte_connection" "recreation_bigquery" {
  name           = "Recreation to BigQuery"
  source_id      = airbyte_source_recreation.my_source_recreation.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [{
      name = "recreationareas"
      },
      {
        name = "facilities"
      },
      {
        name = "activities"
      },
      {
        name = "campsites"
    }]
  }
}
