// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources - Documentation of Source : https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/source_sentry
resource "airbyte_source_sentry" "my_source_sentry" {
  configuration = {
      auth_token = "<Enter Sentry's User Authentication token>"
      # discover_fields = [
      #   "{ \"see\": \"documentation\" }",
      # ]
      # hostname     = "muted-ingredient.biz"
      organization = "<Enter the organization name>"
      project      = "<Enter the project name>"
      source_type  = "sentry"
    }
    name         = "Sentry Source"
    # secret_id    = "...my_secret_id..."
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
resource "airbyte_connection" "sentry_to_snowflake" {
    name = "Sentry to Snowflake Data Warehouse"
    source_id = airbyte_source_sentry.my_source_sentry.source_id
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
                name = "events"
            },
            {
                name = "issues"
            },
            {
              name="project_detail"
            },
            {
              name="projects"
            },
            {
              name="releases"
            }
        ]
        sync_mode = "full_refresh_overwrite"
    }
    schedule = {
        cron_expression = "<Enter your Cron Expression>"
        schedule_type   = "cron"
    }
}