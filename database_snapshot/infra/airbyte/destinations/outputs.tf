output "bigquery_id" {
  value = airbyte_destination_bigquery.bigquery.destination_id
}

output "s3_id" {
  value = airbyte_destination_s3.s3.destination_id
}
