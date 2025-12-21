############################
# Kubernetes Namespace
############################

resource "kubernetes_namespace" "world" {
  metadata {
    name = "world"
  }
}