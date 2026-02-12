terraform {
  required_version = ">= 1.0"
}

module "sample" {
  source = "../modules/sample_module"

  environment = "prod"
}

output "environment" {
  value = "PROD Environment"
}

output "message" {
  value = "Prod pipeline triggered successfully"
}

output "module_output" {
  value = module.sample.message
}
