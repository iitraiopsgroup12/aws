variable "project_name" {
  description = "Project name, for example ledger-lens"
  type        = string
}

variable "environment" {
  description = "Environment name, for example dev"
  type        = string
}

variable "bucket_purpose" {
  description = "Purpose of the bucket, for example documents"
  type        = string
}