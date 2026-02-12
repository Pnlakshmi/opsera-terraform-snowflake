terraform {
  required_version = ">= 1.0"
}

module "sample" {
  source = "../modules/sample_module"

  environment = "qa"
}

output "environment" {
  value = "QA Environment"
}

output "message" {
  value = "QA pipeline triggered successfully"
}

output "module_output" {
  value = module.sample.message
}
