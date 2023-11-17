// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

locals {
  // The BigQuery destination expects a JSON credentials file, but the source expects a JSON string.
  // Read JSON file into a string variable, so we can use the same contents also for the source connector.
  bigquery_credentials_json = replace(
    file(var.bigquery_credentials_json_file_path), "\n", ""
  ) // <- If this fails, please double check that the file exists.

  airbyte_cloud_url = var.airbyte_workspace_id != null ? "https://cloud.airbyte.com/workspaces/${var.airbyte_workspace_id}/connections" : "(n/a)"
}

// Sources
resource "airbyte_source_bigquery" "bigquery" {
    configuration = {
      credentials_json = local.bigquery_credentials_json
      project_id       = var.bigquery_project_id
      dataset_id       = var.bigquery_dataset_id
      source_type      = "bigquery"
    }
    name          = "BigQuery Publishing Source"
    workspace_id  = var.airbyte_workspace_id
}
resource "airbyte_source_notion" "notion_source" {
  configuration = {
    credentials = {
      source_notion_authenticate_using_access_token = {
        auth_type = "token"
        token     = var.notion_token
      }
    }
    source_type = "notion"
    start_date  = "2023-01-01T00:00:00.001Z"  # Note: Fractional seconds with .000 may not work.
  }
  name         = "Notion Data Source"
  workspace_id = var.airbyte_workspace_id
}

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
    configuration = {
        dataset_id = var.bigquery_dataset_id
        dataset_location = var.bigquery_dataset_location
        destination_type = "bigquery"
        project_id = var.bigquery_project_id
        credentials_json = local.bigquery_credentials_json
        loading_method = {
            destination_bigquery_loading_method_standard_inserts = {
                method = "Standard"
            }
        }
    }
    name = "BigQuery Raw Data Destination"
    workspace_id = var.airbyte_workspace_id
}
resource "airbyte_destination_pinecone" "pinecone" {
  configuration = {
    destination_type = "pinecone"
    embedding = {
      destination_pinecone_embedding_open_ai = {
        openai_key = var.openai_key
        mode = "openai"
      }
    }
    indexing = {
      index                = var.pinecone_index
      pinecone_environment = var.pinecone_environment
      pinecone_key         = var.pinecone_key
    }
    processing = {
      chunk_overlap = 16
      chunk_size    = 1024
      metadata_fields = ["url", "last_edited_time"]
      text_fields = ["notion_text"]
    }
  }
  name          = "Pinecone Publish Destination"
  workspace_id  = var.airbyte_workspace_id
}

// Connections
resource "airbyte_connection" "notion_connection" {
    name = "Notion to BigQuery"
    source_id = airbyte_source_notion.notion_source.source_id
    destination_id = airbyte_destination_bigquery.bigquery.destination_id
    namespace_definition = "custom_format"
    namespace_format = var.bigquery_dataset_id
    prefix = "notion_"
    configurations = {
        streams = [
            { name = "blocks" },
            { name = "pages" },
            { name = "users" }
        ]
    }
}
resource "airbyte_connection" "bigquery_to_pinecone" {
    name = "Publish BigQuery Data to Pinecone"
    source_id = airbyte_source_bigquery.bigquery.source_id
    destination_id = airbyte_destination_pinecone.pinecone.destination_id
    configurations = {
        streams = [
            {
              name         = "notion_data",
              cursor_field = ["last_edited_time"],
              primary_key  = [["url"]]
              sync_mode    = "incremental_deduped_history"
            }
        ]
    }
}