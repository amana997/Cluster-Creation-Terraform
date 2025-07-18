variable "aws_region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "ecommerce-cluster"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "desired_capacity" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}
