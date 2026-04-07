# -------------------------------------------------------------------------------
# Create the AWS EKS Cluster ( This is the control plane for Kubernetes on AWS )
# -------------------------------------------------------------------------------
resource "aws_eks_cluster" "main" {

  name     = "${local.resource_name}-eks-cluster"
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster.arn

  # VPC configuration for control plane networking
  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids      = var.eks_cluster_security_group_ids

    # List of CIDRs allowed to reach the public endpoint
    # public_access_cidrs     = var.cluster_endpoint_public_access_cidrs    
  }

  # Ensure IAM policy attachments complete before cluster creation
  # Helps avoid race conditions during provisioning and destroy
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]
  
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP" # Three options: CONFIG_MAP, API, API_AND_CONFIG_MAP
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = {
    Name      = "${local.resource_name}-eks-cluster"
    Env       = var.env
    Project   = var.project
    Terraform = true
  }

}

