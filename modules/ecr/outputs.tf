output "repository_names" {
  description = "ECR repository names"
  value = {
    for service, repo in aws_ecr_repository.this :
    service => repo.name
  }
}

output "repository_urls" {
  description = "ECR repository URLs"
  value = {
    for service, repo in aws_ecr_repository.this :
    service => repo.repository_url
  }
}

output "repository_arns" {
  description = "ECR repository ARNs"
  value = {
    for service, repo in aws_ecr_repository.this :
    service => repo.arn
  }
}