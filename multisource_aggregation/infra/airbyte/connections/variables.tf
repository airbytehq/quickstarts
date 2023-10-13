variable "mysql_id" {
    type = string
}

variable "postgres_id" {
    type = string
}

variable "bigquery_id" {
    type = string
}

variable "airbyte_password" {
    type    = string
    default = "password"
}
