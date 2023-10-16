// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Connections
resource "airbyte_connection" "postgres_to_bigquery" {
    name                = "Postgres to BigQuery"
    source_id           = var.postgres_id
    destination_id      = var.bigquery_id
    prefix              = "pg_"
    schedule = {
        schedule_type   = "manual"
    }
    configurations = {
        streams = [
            {
                cursor_field = ["...",]
                name = "...my_table_name_1..."
                primary_key = [["...",],]
                sync_mode = "full_refresh_append"
            },
            {
                cursor_field = ["...",]
                name = "...my_table_name_2..."
                primary_key = [["...",],]
                sync_mode = "full_refresh_append"
            },
        ]
    }
}

resource "airbyte_connection" "mysql_to_bigquery" {
    name                = "MySQL to BigQuery"
    source_id           = var.mysql_id
    destination_id      = var.bigquery_id
    prefix              = "mysql_"
    schedule = {
        schedule_type   = "manual"
    }
    configurations = {
        streams = [
            {
                cursor_field = ["...",]
                name = "...my_table_name_1..."
                primary_key = [["...",],]
                sync_mode = "full_refresh_append"
            },
            {
                cursor_field = ["...",]
                name = "...my_table_name_2..."
                primary_key = [["...",],]
                sync_mode = "full_refresh_append"
            },
        ]
    }
}