variable "region" {}          #  Actually for vpc creation, it takes region from provider block (For privider.tf)
variable "project_name" {}
variable "env" {}

variable "ami_id" { default = "ami-0ddfba243cbee3768" }
variable "public_key_name" { default = "mumbai-1" }

