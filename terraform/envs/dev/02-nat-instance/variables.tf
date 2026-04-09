variable "ami_id" {}
variable "public_key_name" {}
variable "remote_ip_to_connect_nat_instance" {}

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
