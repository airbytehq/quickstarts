// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

module "sources" {
    source         = "./sources"
    workspace_id   = "...my_workspace_id..."
}

module "destination" {
    source         = "./destinations"
    workspace_id   = "...my_workspace_id..."
}

module "connections" {
    source         = "./connections"
    s3_dest_id     = module.destination.s3_id
    s3_source_id   = module.sources.s3_id
    postgres_id    = module.sources.postgres_id
    bigquery_id    = module.destination.bigquery_id
}
