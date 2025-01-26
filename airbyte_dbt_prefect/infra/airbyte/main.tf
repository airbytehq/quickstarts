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
resource "airbyte_destination_bigquery" "bigquery" {
    configuration = {
        dataset_id = "...my_dataset_id..."
        dataset_location = "...my_dataset_location..."
        destination_type = "bigquery"
        project_id = "...my_project_id..."
        credentials_json = "...my_credentials_json_file_path..."
        loading_method = {
            destination_bigquery_loading_method_standard_inserts = {
                method = "Standard"
            }
        }
    }
    name = "BigQuery"
    workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "postgres_to_bigquery" {
    name = "Postgres to BigQuery"
    source_id = airbyte_source_postgres.postgres.source_id
    destination_id = airbyte_destination_bigquery.bigquery.destination_id
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