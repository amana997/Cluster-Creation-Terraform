variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "node_instance_type" {
  default = "t2.micro"
}

variable "desired_capacity" {
  default = 2
}
