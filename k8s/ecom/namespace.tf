############################
# Kubernetes Namespace
############################

resource "kubernetes_namespace" "ecom" {
  metadata {
    name = "ecom"
  }
}