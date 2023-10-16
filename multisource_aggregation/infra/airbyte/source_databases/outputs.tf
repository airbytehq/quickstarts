
output "postgres_id" {
  value = airbyte_source_postgres.postgres.source_id
}

output "mysql_id" {
  value = airbyte_source_mysql.mysql.source_id
}