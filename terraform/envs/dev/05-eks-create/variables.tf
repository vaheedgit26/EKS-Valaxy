variable "region" {}     # This value can be taken from provider.tf
variable "project" {}
variable "env" {}

#############################################################################################################
variable "s3_bucket_id" {}          # For reading the remote vpc state      (gets value from 'bash script')
variable "vpc_remote_state_key" {}  # Key for refering the vpc remote state (gets value from 'bash script')
#############################################################################################################

variable "db_password" {
  description = "Master password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret for the application"
  type        = string
  sensitive   = true
}
