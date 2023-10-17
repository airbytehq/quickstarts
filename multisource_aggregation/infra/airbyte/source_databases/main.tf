// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_mysql" "mysql" {
  configuration = {
    database            = "...my_database..."
    host                = "...my_host..."
    jdbc_url_params     = "...my_jdbc_url_params..."
    password            = "...my_password..."
    port                = 3306
    source_type         = "mysql"
    username            = "...my_username..."
    replication_method  = {
      source_mysql_update_method_scan_changes_with_user_defined_cursor = {
        method          = "STANDARD"
      }
    }
    ssl_mode = {
      source_mysql_ssl_modes_preferred = {
        mode = "preferred"
      }
    }
    tunnel_method = {
      source_mysql_ssh_tunnel_method_no_tunnel = {
        tunnel_method = "NO_TUNNEL"
      }
    }
  }
  name         = "MySQL"
  secret_id    = "...my_secret_id..."
  workspace_id = var.workspace_id
}

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
