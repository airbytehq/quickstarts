// Airbyte
variable "airbyte_workspace_id" {
  description = <<DESC
  The workspace ID where you would like to deploy the new connections.
  DESC
  type = string
}

variable "airbyte_cloud_auth_key" {
  description = <<DESC
  Your bearer auth key for use with Airbyte Cloud.

  Note: This setting will be ignored if using Airbyte OSS.
  DESC
  type      = string
  sensitive = true
}

variable "bigquery_credentials_json_file_path" {
  description = <<DESC
  The path to your Google credentials JSON file for BigQuery access.

  The service account used should have the `BigQuery User` and `BigQuery Data Editor`

  DESC
  type = string
}
variable "bigquery_project_id" {
  description = <<DESC
  Your BigQuery project ID.
  DESC
  type = string
}
variable "bigquery_dataset_id" {
  description = <<DESC
  Your BigQuery dataset ID.
  DESC
  type = string
}
variable "bigquery_dataset_location" {
  description = <<DESC
  Your BigQuery dataset location.
  DESC
  type = string
}


// Notion
variable "notion_token" {
  description = <<DESC
  Your Notion auth token.
  Note: This requires admin permissions on Notion.

  Airbyte Cloud users can ignore this and set up OAuth credentials manually,
  after deploying to Airbyte Cloud. (Although connection will then not run until OAuth is
  configured.)
  DESC
  type      = string
  sensitive = true
  default   = "...none provided..."
}


// OpenAi
variable "openai_key" {
  description = <<DESC
  Your OpenAI API key.

  If you already have an account with OpenAI, you can generate a new API key
  by visiting this link: https://platform.openai.com/api-keys
  DESC
  type      = string
  sensitive = true
}


// Pinecone
variable "pinecone_key" {
  description = <<DESC
  Your Pinecone API Key.
  DESC
  type      = string
  sensitive = true
}
variable "pinecone_environment" {
  description = <<DESC
  Your Pinecone environment name.
  DESC
  type = string
}
variable "pinecone_index" {
  description = <<DESC
  Your Pinecone index name.
  DESC
  type = string
}
