locals {
  prefix = "aws-${var.project_name}"
}

resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_names)

  name                 = "${local.prefix}-${each.value}-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "${local.prefix}-${each.value}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    Service     = each.value
    ManagedBy   = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = aws_ecr_repository.this

  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}