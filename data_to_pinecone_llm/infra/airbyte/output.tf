// These variables will be printed at the end of a successful `terraform apply`,
// or by running `terraform output` at any time.

output "airbyte_cloud_url" {
    value = local.airbyte_cloud_url  
}
