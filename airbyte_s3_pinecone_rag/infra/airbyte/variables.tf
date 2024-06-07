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

// BigQuery
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


// S3
variable "bucket" {
  description = <<DESC
  Mandatory name of the S3 bucket where the file(s) exist
  DESC
  type      = string
  sensitive = true
  default   = "airbuckets"
}
variable "file_type" {
  description = <<DESC
  File type of the stream
  DESC
  type      = string
  default   = "pdf"
}
variable "aws_access_key_id" {
  description = <<DESC
  Your AWS access key id.
  In order to access private Buckets stored on AWS S3, 
  this connector requires credentials with the proper permissions. 
  If accessing publicly available data, this field is not necessary

  DESC
  type      = string
  sensitive = true
  default   = ""
}
variable "aws_secret_access_key" {
  description = <<DESC
  Your AWS secret access key.
  In order to access private Buckets stored on AWS S3, 
  this connector requires credentials with the proper permissions. 
  If accessing publicly available data, this field is not necessary.
  DESC
  type      = string
  sensitive = true
  default   = ""
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
  default = "https://openai-arhdflg.svc.aped-4627-b74a.pinecone.io"
}
variable "pinecone_index" {
  description = <<DESC
  Your Pinecone index name.
  DESC
  type = string
  default = "openai"
}
