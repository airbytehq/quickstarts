// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

module "sources" {
 source         = "./source_databases"
 workspace_id   = "...my_workspace_id..."
}

module "destination" {
 source         = "./destination_warehouse"
 workspace_id   = "...my_workspace_id..."
}

module "connections" {
 source         = "./connections"
 mysql_id       = module.sources.mysql_id
 postgres_id    = module.sources.postgres_id
 bigquery_id    = module.destination.bigquery_id
}
