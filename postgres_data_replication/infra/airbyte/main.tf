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
    name = "Postgres-Primary"
    workspace_id = var.workspace_id
}

// Destinations
resource "airbyte_destination_postgres" "postgres" {
    configuration = {
        database         = "...my_database..."
        destination_type = "postgres"
        host             = "...my_host..."
        jdbc_url_params  = "...my_jdbc_url_params..."
        password         = "...my_password..."
        port             = 5432
        schema           = "public"
        ssl_mode = {
            destination_postgres_ssl_modes_allow = {
                mode = "allow"
            }
        }
        tunnel_method = {
            destination_postgres_ssh_tunnel_method_no_tunnel = {
                tunnel_method = "NO_TUNNEL"
            }
        }
        username = "...my_username..."
    }
    name         = "Postgres-Secondary"
    workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "postgres_to_postgres" {
    name = "Postgres to Postgres"
    source_id = airbyte_source_postgres.postgres.source_id
    destination_id = airbyte_destination_postgres.postgres.destination_id
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
    schedule = {
        cron_expression = "...my_cron_expression..."
        schedule_type   = "cron"
    }
}