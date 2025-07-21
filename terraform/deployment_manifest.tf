data "local_file" "nginx_manifest" {
  filename = "/Users/aman/Documents/Git/Cluster-Creation-Terraform/terraform/k8s/nginx-deployment.yaml"
}

resource "kubernetes_manifest" "nginx" {
  for_each = {
    for doc in yamldecode(data.local_file.nginx_manifest.content) : doc["metadata"]["name"] => doc
  }

  manifest = each.value
}