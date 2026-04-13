# --------------------------------------------------------------------
# Reference the Remote State from VPC Project
# --------------------------------------------------------------------
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.s3_bucket_id                                             # Name of the remote S3 bucket where the VPC state is stored (gets value from 'bash script')
    key    = "${var.project}/${var.env}/vpc/terraform.tfstate"            # "pharma/dev/vpc/terraform.tfstate"     # Path to the VPC tfstate file within the bucket
    region = var.region                                                   # Region where the S3 bucket and DynamoDB table exist (gets value from 'bash script')
  }
}

# --------------------------------------------------------------------
# Output the VPC ID from the remote VPC state
# --------------------------------------------------------------------
output "vpc_id_using_remote_state" { 
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}

# --------------------------------------------------------------------
# Output the list of private subnets from the VPC
# --------------------------------------------------------------------
output "private_subnet_ids_using_remote_state" {
  value = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}


# --------------------------------------------------------------------
# Output the list of public subnets from the VPC
# --------------------------------------------------------------------
output "public_subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.public_subnet_ids
}
