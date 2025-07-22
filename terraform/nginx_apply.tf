resource "null_resource" "apply_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ap-south-1 --name my-eks-cluster"
  }
  provisioner "local-exec" {
    command = "kubectl apply -f /Users/aman/Documents/Git/Cluster-Creation-Terraform/k8s/nginx-deployment.yaml"
  }
  provisioner "local-exec" {
    command = "kubectl get nodes"
  }
  provisioner "local-exec" {
    command = "kubectl get pods -A"
  }
  provisioner "local-exec" {
    command = "kubectl get svc"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f /Users/aman/Documents/Git/Cluster-Creation-Terraform/k8s/nginx-deployment.yaml"
  }

  # Update this with your actual EKS cluster resource name
  depends_on = [
    module.eks.eks_managed_node_groups
  ]
}