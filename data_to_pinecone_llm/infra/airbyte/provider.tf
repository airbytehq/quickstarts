// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

terraform {
  required_providers {
    airbyte = {
      source = "airbytehq/airbyte"
      version = "0.3.4"
    }
  }
}

/////////////////////////////////
// Airbyte Provider Definition //
/////////////////////////////////

// Uncomment the OSS or Cloud block, depending on your desired deployment location:

// Airbyte Cloud:
provider "airbyte" {
  bearer_auth = var.airbyte_cloud_auth_key
}

# // Airbyte OSS:
# provider "airbyte" {
#   // Optionally override the airbyte-api-server URL
#   server_url = "http://localhost:8006/v1"

#   // Optionally override the default password/username below
#   username = "airbyte"
#   password = "password"  
# }
