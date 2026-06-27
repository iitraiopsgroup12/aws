variable "project_name" {
  description = "Project name, for example ledger-lens"
  type        = string
}

variable "environment" {
  description = "Environment name, for example dev"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be created"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "VPC CIDR allowed to access PostgreSQL"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "ledgerlens"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "ledgerlens"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}