###############################################################
# Usage: sh delete-s3-bucket.sh <project_name> <env> <region  #
###############################################################

#!/usr/bin/env bash
set -e

PROJECT_NAME=$1
ENV=$2
REGION=$3

# terraform init

cd ..

terraform destroy \
  -var="project_name=$PROJECT_NAME" \
  -var="env=$ENV" \
  -var="region=$REGION"
  # -auto-approve


# terraform plan -destroy \
#  -var="project_name=expense" \
#  -var="env=dev" \
#  -var="region=ap-south-1" \
#  -out=destroy.tfplan

# terraform apply destroy.tfplan

####################################################################
# In VPC :: 
#   project_name
#   env
#   region
   
# In EKS ::
#   project
#   env
#   region
