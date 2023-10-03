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
            source_postgres_replication_method_standard = {
                method = "Standard"
            }
        }
    }
    name = "Postgres"
    workspace_id = var.workspace_id
}

// Destinations
resource "airbyte_destination_snowflake" "snowflake" {
    configuration = {
        credentials = {
            source_snowflake_authorization_method_o_auth2_0 = {
                access_token  = "...my_access_token..."
                auth_type     = "OAuth"
                client_id     = "...my_client_id..."
                client_secret = "...my_client_secret..."
                refresh_token = "...my_refresh_token..."
            }
        }
        database        = "AIRBYTE_DATABASE"
        host            = "accountname.us-east-2.aws.snowflakecomputing.com"
        jdbc_url_params = "...my_jdbc_url_params..."
        role            = "AIRBYTE_ROLE"
        schema          = "AIRBYTE_SCHEMA"
        source_type     = "snowflake"
        warehouse       = "AIRBYTE_WAREHOUSE"
    }
    name         = "Katrina Tillman"
    secret_id    = "...my_secret_id..."
    workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "postgres_to_snowflake" {
    name = "Postgres to Snowflake"
    source_id = airbyte_source_postgres.postgres.source_id
    destination_id = airbyte_destination_snowflake.snowflake.destination_id
    configurations = {
        streams = [
            {
                name = "...my_table_name_1..."
            },
            {
                name = "...my_table_name_2..."
            },
        ]
    }
}