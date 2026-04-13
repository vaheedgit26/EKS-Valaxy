# -------------------------------------------------------------------------------
# Create the AWS EKS Cluster ( This is the control plane for Kubernetes on AWS )
# -------------------------------------------------------------------------------
resource "aws_eks_cluster" "main" {

  name     = "${local.eks_cluster_name}"
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster.arn

  # VPC configuration for control plane networking
  vpc_config {
    subnet_ids              = var.cluster_subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    security_group_ids      = var.cluster_addl_security_group_ids
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"            # Three options: CONFIG_MAP, API, API_AND_CONFIG_MAP
    bootstrap_cluster_creator_admin_permissions = true    # Gives admin access to user who creates this EKS Cluster
  }

  # Ensure IAM policy attachments complete before cluster creation
  # Helps avoid race conditions during provisioning and destroy
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceController
  ]

  tags = {
    Name      = "${local.eks_cluster_name}"
    Env       = var.env
    Project   = var.project
    Terraform = true
  }

}

