variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes Version"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "EKS Cluster IAM Role ARN"
  type        = string
}

variable "node_role_arn" {
  description = "Worker Node IAM Role ARN"
  type        = string
}