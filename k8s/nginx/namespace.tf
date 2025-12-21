############################
# Kubernetes Namespace
############################

resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}