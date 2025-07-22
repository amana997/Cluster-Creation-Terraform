resource "null_resource" "apply_config" {
  provisioner "local-exec" {
    when    = create
    command = <<EOT
      aws eks update-kubeconfig --region ap-south-1 --name my-eks-cluster
      sleep 10
      kubectl apply -f /Users/aman/Documents/Git/Cluster-Creation-Terraform/k8s/nginx-deployment.yaml
      sleep 10
      kubectl get nodes
      sleep 10
      kubectl get pods -A
      sleep 10
      open "http://$(kubectl get svc | grep ".com" | awk '{print $4}' | tr -d '\n')"
    EOT
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