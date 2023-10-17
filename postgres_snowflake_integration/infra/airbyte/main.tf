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
            source_postgres_update_method_read_changes_using_write_ahead_log_cdc = {
                method = "CDC"
                publication = "...pub..."
                replication_slot = "...slot..."
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
            destination_snowflake_authorization_method_key_pair_authentication = {
                auth_type            = "Key Pair Authentication"
                private_key          = "...my_private_key..."
                private_key_password = "...my_private_key_password..."
            }
        }
        database         = "AIRBYTE_DATABASE"
        destination_type = "snowflake"
        host             = "accountname.us-east-2.aws.snowflakecomputing.com"
        jdbc_url_params  = "...my_jdbc_url_params..."
        raw_data_schema  = "...my_raw_data_schema..."
        role             = "AIRBYTE_ROLE"
        schema           = "AIRBYTE_SCHEMA"
        username         = "AIRBYTE_USER"
        warehouse        = "AIRBYTE_WAREHOUSE"
    }
    name         = "Snowflake"
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
