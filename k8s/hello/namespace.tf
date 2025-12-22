############################
# Kubernetes Namespace
############################

resource "kubernetes_namespace" "hello" {
  metadata {
    name = "hello"
  }
}