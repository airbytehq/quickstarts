// Airbyte
variable "workspace_id" {
    type = string
}


// BigQuery
variable "bigquery_credentials_json" {
  type = string
  sensitive = true
}
variable "bigquery_credentials_json_file_path" {
  type = string
}
variable "bigquery_project_id" {
  type = string
}
variable "bigquery_dataset_id" {
  type = string
}
variable "bigquery_dataset_location" {
  type = string
}


// Notion
variable "notion_token" {
  type = string
  sensitive = true
}


// OpenAi
variable "openai_key" {
  type = string
  sensitive = true
}


// Pinecone
variable "pinecone_key" {
  type = string
  sensitive = true
}
variable "pinecone_environment" {
  type = string
}
variable "pinecone_index" {
  type = string
}
