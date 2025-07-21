terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.26"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # or use `config_raw` from data.aws_eks_cluster_auth
}
