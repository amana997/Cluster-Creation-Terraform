resource "null_resource" "apply_nginx_yaml" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/nginx-deployment.yaml"
  }

  # Update this with your actual EKS cluster resource name
  depends_on = [
    module.eks.cluster_name
  ]
}