locals {

  prefix = "aws-${var.project_name}"

  vpc_name = "${local.prefix}-vpc-${var.environment}"

}

module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8"

  name = local.vpc_name

  cidr = var.vpc_cidr

  azs = var.availability_zones

  public_subnets = var.public_subnets

  enable_nat_gateway = false

  enable_vpn_gateway = false

  map_public_ip_on_launch = true

  enable_dns_hostnames = true

  enable_dns_support = true

  public_subnet_tags = {

    "Name" = "${local.prefix}-public-subnet-${var.environment}"

    "kubernetes.io/role/elb" = "1"

  }

  tags = {

    Project = var.project_name

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}