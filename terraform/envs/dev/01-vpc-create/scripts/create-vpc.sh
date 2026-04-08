################################################
# Usage: bash create-vpc.sh    #
################################################
# This script takes 'bucket', 'env', region' and 'project_name' as inputs from previous '0-s3' calling module 

#!/usr/bin/env bash
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

# Step 0: Go to repo root
# cd "$(dirname "$0")"

echo "============================================="
echo "Step 1: Initialiaze VPC Module "
echo "============================================="
cd ..

terraform init -upgrade \
  -backend-config="bucket=${BUCKET}" \
  -backend-config="key=${ENV}/vpc/terraform.tfstate" \
  -backend-config="region=${REGION}" \
  -backend-config="encrypt=true" \
  -backend-config="use_lockfile=true"


echo "===================================================="
echo "Step 2: Checking VPC Configuration Validity ? "
echo "===================================================="
terraform validate

echo "================================================"
echo "Step 3: Generating plan for creating VPC  "
echo "================================================"
# terraform plan
terraform plan \
  -out=vpc.tfplan \
  -var="project_name=$PROJECT_NAME" \
  -var="env=$ENV" \
  -var="region=$REGION"
  

echo "================================================"
echo "Step 4: Applying plan for creating VPC          "
echo "================================================"
terraform apply vpc.tfplan    # -auto-approve
