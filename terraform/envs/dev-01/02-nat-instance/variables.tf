# variable "ami_id" {}
# variable "public_key_name" {}
variable "remote_ip_to_connect_nat_instance" {}

variable "vpc_id" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "public_subnet_ids" { type = list }
# variable "private_subnet_ids" { type = list }

variable "bucket_name" {}
variable "vpc_state_key" {}
variable "region" {}

#############  Tags ###############################################
variable "project_name" { default = "expense" }
variable "env" { default = "dev" }

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
    Terraform   = "true"
  }
}
###################################################################
