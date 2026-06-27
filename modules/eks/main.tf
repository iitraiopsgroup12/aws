locals {

  prefix = "aws-${var.project_name}"

  cluster_name = "${local.prefix}-eks-${var.environment}"

}

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  ####################################################
  # Networking
  ####################################################

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  ####################################################
  # Endpoint
  ####################################################

  cluster_endpoint_public_access = true

  ####################################################
  # Authentication
  ####################################################

  enable_cluster_creator_admin_permissions = true

  ####################################################
  # IAM Roles
  ####################################################

  iam_role_arn = var.cluster_role_arn

  ####################################################
  # Managed Node Group
  ####################################################

  eks_managed_node_groups = {

    default = {

      name = "${local.prefix}-nodegroup-${var.environment}"

      iam_role_arn = var.node_role_arn

      instance_types = [
        "t3.micro"
      ]

      capacity_type = "ON_DEMAND"

      desired_size = 1

      min_size = 1

      max_size = 1

      disk_size = 30

    }

  }

  ####################################################
  # Tags
  ####################################################

  tags = {

    Name = local.cluster_name

    Project = var.project_name

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}