variable "s3_source_id" {
    type = string
}

variable "postgres_id" {
    type = string
}

variable "s3_dest_id" {
    type = string
}

variable "bigquery_id" {
    type = string
}

variable "airbyte_password" {
    type    = string
    default = "password"
}
