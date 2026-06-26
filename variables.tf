variable "environment" {
  description = "The target deployment environment. Value is sourced from the environment-scoped tfvars file."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}
