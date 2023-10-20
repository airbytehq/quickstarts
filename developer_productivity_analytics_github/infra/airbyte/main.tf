
// source
resource "airbyte_source_github" "my_source_github" {
  configuration = {
    credentials = {
      source_github_authentication_personal_access_token = {
        personal_access_token = var.personal_access_token
      }
    }
    repository  = var.repository
    source_type = "github"
    start_date  = "2023-09-01T00:00:00Z"
  }
  name         = "your_name"
  workspace_id = var.workspace_id
}


// destination
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


// connection
resource "airbyte_connection" "github_bigquery" {
  name           = "Github to bigquery"
  source_id      = airbyte_source_github.my_source_github.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "users"
      },
      {
        name = "teams"
      },
      {
        name = "tags"
      },
      {
        name = "stargazers"
      },
      {
        name = "repositories"
      },
      {
        name = "pull_requests"
      },
      {
        name = "organizations"
      },
      {
        name = "issues"
      },
      {
        name = "commits"
      },
      {
        name = "comments"
      }, 
      {
        name = "branches"
      },
      {
        name = "reviews"
      },
      {
        name = "review_comments"
      },
      {
        name = "collaborators"
      }
    ]
  }
}
