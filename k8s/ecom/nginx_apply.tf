resource "null_resource" "apply_config" {
  provisioner "local-exec" {
    when    = create
    command = <<EOT
      aws eks update-kubeconfig --region ap-south-1 --name my-eks-cluster
      sleep 10
      kubectl apply -n ecommerce -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml
      sleep 10
      kubectl get nodes
      sleep 10
      kubectl get pods -A
      sleep 10
      open "http://$(kubectl get svc -n ecommerce | grep ".com" | awk '{print $4}' | tr -d '\n')"
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      kubectl delete -n ecommerce -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml
      sleep 10
    EOT
  }

  # Update this with your actual EKS cluster resource name
  depends_on = [
    kubernetes_namespace.ecom
  ]
}