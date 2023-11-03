// Source
resource "airbyte_source_shopify" "my_source_shopify" {
  configuration = {
    credentials = {
      source_shopify_shopify_authorization_method_api_password = {
        api_password = var.api_password
        auth_method  = "api_password"
      }
    }
    shop        = var.shop
    source_type = "shopify"
  }
  name         = "Shopify"
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
resource "airbyte_connection" "shopify_bigquery" {
  name           = "Shopify to BigQuery"
  source_id      = airbyte_source_shopify.my_source_shopify.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "customers"
      },
      {
        name = "transactions"
      },
      {
        name = "abandoned_checkouts"
      }
    ]
  }
}