terraform {
  required_version = ">= 1.0"
}

module "sample" {
  source = "../modules/sample_module"

  environment = "common"
}

output "environment" {
  value = "COMMON Environment"
}

output "message" {
  value = "Common pipeline triggered successfully"
}

output "module_output" {
  value = module.sample.message
}
