variable "project_name" {
  description = "Project name, for example ledger-lens"
  type        = string
}

variable "environment" {
  description = "Environment name, for example dev"
  type        = string
}

variable "repository_names" {
  description = "Short service names for ECR repositories"
  type        = list(string)
}