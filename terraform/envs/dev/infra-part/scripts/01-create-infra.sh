################################################
# Usage: bash create-vpc.sh    #################
################################################
# This script takes 'bucket', 'env', region' and 'project_name' as inputs from previous '00-s3-create' calling module 

#!/usr/bin/env bash
set -e

BUCKET=$(terraform -chdir=../../00-s3-create output -raw bucket_id)              
ENV=$(terraform -chdir=../../00-s3-create output -raw env)                       
REGION=$(terraform -chdir=../../00-s3-create output -raw region)                 
PROJECT_NAME=$(terraform -chdir=../../00-s3-create output -raw project_name)

echo """
📄 Details:
     PROJECT_NAME : ${PROJECT_NAME}
     ENV          : ${ENV}
     REGION       : ${REGION}
     BUCKET       : ${BUCKET}
"""

# Step 0: Go to repo root
# cd "$(dirname "$0")"

echo "====================="
echo " Step 1: Initialiaze "
echo "====================="
cd ..

terraform init -upgrade \
  -backend-config="bucket=${BUCKET}" \
  -backend-config="key=${PROJECT_NAME}/${ENV}/vpc/terraform.tfstate" \
  -backend-config="region=${REGION}" \
  -backend-config="encrypt=true" \
  -backend-config="use_lockfile=true"

echo "==========================================="
echo " Step 2: Checking Configuration Validity ? "
echo "==========================================="
terraform validate

echo "==================================="
echo " Step 3: Generating Terraform plan "
echo "==================================="
# terraform plan
terraform plan \
  -out=infra.tfplan \
  -var="project_name=$PROJECT_NAME" \
  -var="env=$ENV" \
  -var="region=$REGION"
  
echo "================================="
echo " Step 4: Applying Terraform plan "
echo "================================="
terraform apply infra.tfplan    # -auto-approve


####################################################################
# In VPC :: 
#   project_name
#   env
#   region
   
# In EKS ::
#   project
#   env
#   region
