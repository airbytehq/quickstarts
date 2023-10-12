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
resource "airbyte_destination_mysql" "mysql" {
    configuration = {
        host             = "...my_host..."
        port             = 3306
        destination_type = "mysql"
        database         = "...my_database..."
        schema           = "public"
        username = "...my_username..."
        password         = "...my_password..."
        jdbc_url_params  = "...my_jdbc_url_params..."
        tunnel_method = {
            destination_mysql_ssh_tunnel_method_no_tunnel = {
                tunnel_method = "NO_TUNNEL"
            }
        }
        ssl_method = {
            ssl_method =  "unencrypted"
        }        
    }
    name         = "Mysql"
    workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "postgres_to_mysql" {
    name = "Postgres to Mysql"
    source_id = airbyte_source_postgres.postgres.source_id
    destination_id = airbyte_destination_mysql.mysql.destination_id
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