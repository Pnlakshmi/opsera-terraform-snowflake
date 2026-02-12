variable "environment" {
  description = "Environment name"
  type        = string
}

output "message" {
  value = "Module loaded for ${var.environment} environment"
}
