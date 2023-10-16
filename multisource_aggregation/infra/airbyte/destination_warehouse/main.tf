// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
    configuration = {
        dataset_id = "...my_dataset_id..."
        dataset_location = "...my_dataset_location..."
        destination_type = "bigquery"
        project_id = "...my_project_id..."
        credentials_json = "...my_credentials_json_file_path..."
        loading_method = {
            destination_bigquery_loading_method_standard_inserts = {
                method = "Standard"
            }
        }
    }
    name = "BigQuery"
    workspace_id = var.workspace_id
}
