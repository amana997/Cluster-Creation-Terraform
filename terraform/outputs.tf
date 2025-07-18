output "instance_ips" {
  value = [for instance in aws_instance.cluster : instance.public_ip]
}