// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_postgres" "postgres" {
    configuration = {
        database = "...my_database..."
        host = "...my_host..."
        username = "...my_username..."
        password = "...my_password..."
        port = 5432
        source_type = "postgres"
        schemas = [
            "...my_schema..."
        ]
        ssl_mode = {
            source_postgres_ssl_modes_allow = {
                mode = "allow"
            }
        }
        tunnel_method = {
            source_postgres_ssh_tunnel_method_no_tunnel = {
                tunnel_method = "NO_TUNNEL"
            }
        }
        replication_method = {
            source_postgres_update_method_scan_changes_with_user_defined_cursor = {
                method = "Standard"
            }
        }
    }
    name = "Postgres"
    workspace_id = var.workspace_id
}

resource "airbyte_source_s3" "s3" {
  configuration = {
    bucket      = "...my_bucket..."
    source_type = "s3"
    streams = [
      {
        file_type = "...my_file_type..."
        name      = "...my_stream_name..."

        format = {
          source_s3_file_based_stream_config_format_jsonl_format = {
            filetype = "jsonl"
          }
        }
        globs = [
          "postgres_snapshot/table/...my_stream_name.../*.jsonl*",
        ]
        primary_key       = "...my_primary_key..."
      },
    ]

    aws_access_key_id     = "...my_aws_access_key_id..."
    aws_secret_access_key = "...my_aws_secret_access_key..."
  }
  name         = "S3"
  workspace_id = var.workspace_id
}