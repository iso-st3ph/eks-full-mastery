variable "region" { default = "us-east-1" }
variable "cluster_name" { default = "isovault-eks-lab" }

variable "vpc_cidr" { default = "10.10.0.0/16" }

variable "public_subnets" {
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnets" {
  default = ["10.10.101.0/24", "10.10.102.0/24"]
}
