// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_github" "github" {
  configuration = {
    access_token = var.github_access_token // You'll need to provide the GitHub access token as a variable.
    repository   = var.github_repository   // The GitHub repository you want to pull data from.
    start_date   = "2023-01-01"            // Starting date from which data should be pulled. Modify as needed.
    source_type  = "github"
  }
  name         = "GitHub"
  workspace_id = var.workspace_id
}

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
    configuration = {
        dataset_id = var.dataset_id
        dataset_location = "US"
        destination_type = "bigquery"
        project_id = var.project_id
        credentials_json = var.credentials_json
        loading_method = {
            destination_bigquery_loading_method_standard_inserts = {
                method = "Standard"
            }
        }
    }
    name = "BigQuery"
    workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "github_to_bigquery" {
    name = "GitHub to BigQuery"
    source_id = airbyte_source_github.github.source_id
    destination_id = airbyte_destination_bigquery.bigquery.destination_id
    configurations = {
        streams = [
            {
                name = "commits"  // Modify to match the GitHub streams you want to sync.
            },
            {
                name = "issues"
            },
            {
                name = "pull_requests"
            },
            // Add or remove any other streams as per your needs.
        ]
    }
}