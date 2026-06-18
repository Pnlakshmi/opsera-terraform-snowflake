terraform {
  required_version = ">= 1.0"
}

module "sample" {
  source = "../modules/sample_module"

  environment = "dev"
}

output "environment" {
  value = "DEV Environment"
}

output "message" {
  value = "Dev pipeline triggered successfully test webhook email"
}

output "module_output" {
  value = module.sample.message
}
