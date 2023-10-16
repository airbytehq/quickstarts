// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources - Documentation of Source : https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/source_github
resource "airbyte_source_github" "my_source_github" {
  configuration = {
    # branch = ""
    credentials = {
      source_github_authentication_personal_access_token = {
        // Log into GitHub and then generate a personal access token. To load balance your API quota consumption across multiple API tokens, input multiple tokens separated with ","

        personal_access_token = "<Enter your personal access github token>"

      }
    }
    repository        = "<Enter the repository that you want to extract the data. (Exp - airbyte/* - all data of repositories of airbyte organization)>"
    # requests_per_hour = 10
    source_type       = "github"
    // Enter the date
    start_date        = "<Enter the Start date>"
  }
  name         = "Github API"
#   secret_id    = "...my_secret_id..."
  workspace_id = var.workspace_id
}

// Destinations - Documentation of Destination: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/destination_snowflake
resource "airbyte_destination_snowflake" "my_destination_snowflake" {
  configuration = {
    credentials = {
      destination_snowflake_authorization_method_username_and_password = {
        password = "<Enter your created user's Password in Snowflake>"
      }
    }
    database         = "<Enter your Snowflake database name>"
    destination_type = "snowflake"
    host             = "<Enter Snowflake's host>"
    # jdbc_url_params  = "...my_jdbc_url_params..."
    # raw_data_schema  = "...my_raw_data_schema..."
    role             = "<Enter the role of created Snowflake User>"
    schema           = "<Enter the name of Snowflake Schema>"
    username         = "<Enter the name of Snowflake Username>"
    warehouse        = "<Enter the naoe of Snowflake Warehouse>"
  }
  name         = "Snowflake Warehouse"
  workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "github_to_snowflake" {
    name = "Github API to Snowflake Data Warehouse"
    source_id = airbyte_source_github.my_source_github.source_id
    destination_id = airbyte_destination_snowflake.my_destination_snowflake.destination_id
    status = "active"
    configurations = {

        // Available Streams = Comments, Commit comment reactions, Commit comments,
        #  Commits, Deployments, Events, Issue comment reactions, Issue events, Issue milestones,
        #   Issue reactions, Issues, Project cards, Project columns, Projects, Pull request comment reactions,
        #    Pull requests, Pull request stats, Releases, Review comments, Reviews, Stargazers, Workflow runs, 
        #    Workflows
        streams = [
            {
                name = "projects"
            },
            {
                name = "commits"
            },
        ]
        sync_mode = "full_refresh_overwrite"
    }
    schedule = {
        cron_expression = "<Enter your Cron Expression>"
        schedule_type   = "cron"
    }
}