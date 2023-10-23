
// Source
resource "airbyte_source_mysql" "my_source_mysql" {
  configuration = {
    database = "...my_database..."
    host     = "...my_host..."
    port     = 3306
    replication_method = {
      source_mysql_update_method_read_changes_using_binary_log_cdc_ = {
        initial_waiting_seconds = 10
        method                  = "CDC"
        server_time_zone        = "...my_server_time_zone..."
      }
    }
    source_type = "mysql"
    tunnel_method = {
      source_mysql_ssh_tunnel_method_no_tunnel = {
        tunnel_method = "NO_TUNNEL"
      }
    }
    username = "...my_username..."
  }
  name         = "MySQL"
  workspace_id = var.workspace_id
}

// Destination
resource "airbyte_destination_postgres" "my_destination_postgres" {
  configuration = {
    database         = "...my_database..."
    destination_type = "postgres"
    host             = "...my_host..."
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
  name         = "Postgres"
  workspace_id = var.workspace_id
}

// Connection
resource "airbyte_connection" "mysql_to_postgres" {
  name           = "Mysql to Postgres"
  source_id      = airbyte_source_mysql.my_source_mysql.source_id
  destination_id = airbyte_destination_postgres.my_destination_postgres.destination_id
  configurations = {
    streams = [{
      cursor_field = ["...", ]
      name         = "...my_table_name_1..."
      primary_key  = [["...", ], ]
      sync_mode    = "incremental_append"
    }]
  }
}
