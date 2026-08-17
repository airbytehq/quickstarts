// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

terraform {
  required_providers {
    airbyte = {
      source = "airbytehq/airbyte"
      version = "0.3.3"
    }
  }
}

provider "airbyte" {
  // If running locally (Airbyte OSS) with docker-compose using the airbyte-proxy, 
  // include the actual password/username you've set up (or use the defaults below)
  username = "airbyte"
  password = "password"
  
  // if running locally (Airbyte OSS), include the server url to the airbyte-api-server
  server_url = "http://localhost:8006/v1"
}