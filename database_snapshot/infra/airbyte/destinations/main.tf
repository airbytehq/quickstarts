// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
    configuration = {
        dataset_id = "...my_dataset_id..."
        dataset_location = "...my_dataset_location..."
        destination_type = "bigquery"
        project_id = "...my_project_id..."
        credentials_json = "...my_credentials_json_string..."
        loading_method = {
            destination_bigquery_loading_method_standard_inserts = {
                method = "Standard"
            }
        }
    }
    name = "BigQuery"
    workspace_id = var.workspace_id
}

resource "airbyte_destination_s3" "s3" {
  configuration = {
    destination_type  = "s3"
    format = {
      destination_s3_output_format_json_lines_newline_delimited_json = {
        format_type = "JSONL"
      }
    }
    s3_bucket_name    = "...my_bucket..."
    s3_bucket_path    = "postgres_snapshot/table"
    s3_bucket_region  = "...my_bucket_region..."
    
    access_key_id     = "...my_aws_access_key_id..."
    secret_access_key = "...my_aws_secret_access_key..."
  }
  name         = "S3"
  workspace_id = var.workspace_id
}