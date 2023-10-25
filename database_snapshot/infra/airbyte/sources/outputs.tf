
output "postgres_id" {
  value = airbyte_source_postgres.postgres.source_id
}

output "s3_id" {
  value = airbyte_source_s3.s3.source_id
}