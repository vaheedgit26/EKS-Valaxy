###########################################################
# Usage: bash delete-vpc.sh <project_name> <env> <region> #
###########################################################

#!/bin/bash
set -e

BUCKET=$(terraform -chdir=../../0-s3 output -raw bucket_id)              
ENV=$(terraform -chdir=../../0-s3 output -raw env)                       
REGION=$(terraform -chdir=../../0-s3 output -raw region)                 
PROJECT_NAME=$(terraform -chdir=../../0-s3 output -raw project_name)

echo """
📄 Details:
     PROJECT_NAME : ${PROJECT_NAME}
     ENV          : ${ENV}
     REGION       : ${REGION}
     BUCKET       : ${BUCKET}
"""

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
