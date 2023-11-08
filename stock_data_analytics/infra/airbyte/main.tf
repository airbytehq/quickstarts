// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_polygon_stock_api" "my_source_polygonstockapi" {
  configuration = {
    api_key       = var.api_key
    end_date      = "2023-09-28"
    multiplier    = 1
    sort          = "asc"
    source_type   = "polygon-stock-api"
    start_date    = "2023-09-26"
    stocks_ticker = "IBM"
    timespan      = "day"
  }
  name         = "Polygon Stock API"
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
resource "airbyte_connection" "polygon_bigquery" {
  name           = "Weatherstack to BigQuery"
  source_id      = airbyte_source_polygon_stock_api.my_source_polygonstockapi.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "stock-api"
      }
    ]
  }
}