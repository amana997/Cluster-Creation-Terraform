############################
# Kubernetes Provider
############################

data "aws_eks_cluster" "eks" {
  name = var.cluster_name.name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.eks.certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.eks.token
}

############################
# Hello World Deployment
############################

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world"
    labels = {
      app = "hello-world"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "hello-world"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }

      spec {
        container {
          name  = "hello-world"
          image = "nginxdemos/hello"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

############################
# Service (LoadBalancer)
############################

resource "kubernetes_service" "hello_world" {
  metadata {
    name = "hello-world-service"
  }

  spec {
    selector = {
      app = "hello-world"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

############################
# Output
############################

output "hello_world_url" {
  value = kubernetes_service.hello_world.status[0].load_balancer[0].ingress[0].hostname
}