// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_mongodb" "mongodb" {
  configuration = {
    auth_source = "admin"
    database    = "...my_database..."
    instance_type = {
      source_mongodb_mongo_db_instance_type_mongo_db_atlas = {
        cluster_url = "...my_cluster_url..."
        instance    = "atlas"
      }
    }
    password    = "...my_password..."
    source_type = "mongodb"
    user        = "...my_user..."
  }
  name         = "MongoDB-Source"
  secret_id    = "...my_secret_id..."
  workspace_id = var.workspace_id
}

// Destinations
resource "airbyte_destination_mysql" "mysql" {
  configuration = {
    database         = "...my_database..."
    destination_type = "mysql"
    host             = "...my_host..."
    jdbc_url_params  = "...my_jdbc_url_params..."
    password         = "...my_password..."
    port             = 3306
    tunnel_method = {
      destination_mysql_ssh_tunnel_method_no_tunnel = {
        tunnel_method = "NO_TUNNEL"
      }
    }
    username = "...my_username..."
  }
  name         = "MySql-Destination"
  workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "mongodb_to_mysql" {
    name = "MongoDB to MySQL"
    source_id = airbyte_source_mongodb.mongodb.source_id
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
