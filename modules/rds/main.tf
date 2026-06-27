locals {
  prefix = "aws-${var.project_name}"

  rds_name          = "${local.prefix}-rds-${var.environment}"
  subnet_group_name = "${local.prefix}-rds-subnet-group-${var.environment}"
  security_group    = "${local.prefix}-rds-sg-${var.environment}"
}

resource "aws_db_subnet_group" "this" {
  name       = local.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name        = local.subnet_group_name
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_security_group" "this" {
  name        = local.security_group
  description = "Security group for LedgerLens PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = local.security_group
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_instance" "this" {
  identifier = local.rds_name

  engine         = "postgres"
  engine_version = "15"
  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 5432

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  publicly_accessible = true

  backup_retention_period = 1
  deletion_protection     = false
  skip_final_snapshot     = true

  auto_minor_version_upgrade = true

  tags = {
    Name        = local.rds_name
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}