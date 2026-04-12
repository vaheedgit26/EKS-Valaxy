# project_name, env and region extracted from S3 Bucket 
variable "region" {}          #  Actually for vpc creation, it takes region from provider block (For privider.tf)
variable "project_name" {}
variable "env" {}

########################################################
variable "ami_id" {}
variable "public_key_name" {}

