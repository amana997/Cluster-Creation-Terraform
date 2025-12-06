module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = var.cluster_name
  cluster_version = "1.34"
  
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id

  eks_managed_node_groups = {
    dev = {
      instance_types = [var.node_instance_type]
      desired_size   = var.desired_capacity
      min_size       = 1
      max_size       = 3
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    Admins = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::863379711167:role/aws-reserved/sso.amazonaws.com/ap-south-1/AWSReservedSSO_AdministratorAccess_001b76da22c136b4"

      policy_associations = {
        Cluster_Admins = {
          policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope   = { type = "cluster" }
        }
      }
    }
  }
}