variable "region" {
  default = "ap-south-1"
}

variable "instance_count" {
  default = 3
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c2b8ca1dad447f8a" # Update based on region
}