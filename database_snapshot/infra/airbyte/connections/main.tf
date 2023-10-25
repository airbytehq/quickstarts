// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Connections
resource "airbyte_connection" "postgres_to_s3" {
    name                = "Postgres to S3"
    source_id           = var.postgres_id
    destination_id      = var.s3_dest_id
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
            }
        ]
    }
}

resource "airbyte_connection" "s3_to_bigquery" {
    name                = "S3 to BigQuery"
    source_id           = var.s3_source_id
    destination_id      = var.bigquery_id
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
            }
        ]
    }
}