// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_zendesk_support" "my_source_zendesksupport" {
  configuration = {
    source_type = "zendesk-support"
    credentials = {
      source_zendesk_support_authentication_api_token = {
        credentials = "api_token"
        api_token   = var.api_token
        email       = var.email

      }

    }
    start_date = "2020-10-15T00:00:00Z"
    subdomain  = "self3836"
  }
  name         = "Zendesk Support"
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
resource "airbyte_connection" "zendesk_support_bigquery" {
  name           = "Zendesk Support to BigQuery"
  source_id      = airbyte_source_zendesk_support.my_source_zendesksupport.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "users"
      },
      {
        name = "tickets"
      },
      {
        name = "satisfaction_ratings"
      },
      {
        name = "ticket_metrics"
      },
      {
        name = "ticket_metric_events"
      },
      {
        name = "ticket_comments"
      },
      {
        name = "ticket_audits"
      }
    ]
  }
}
