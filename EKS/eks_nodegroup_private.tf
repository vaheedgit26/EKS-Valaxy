# EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.resource_name}-node-group"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = var.node_subnet_ids
  instance_types  = var.node_instance_types
  capacity_type   = var.node_capacity_type   ON_DEMAND/ SPOT
  disk_size       = var.node_disk_size

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    # max_unavailable_percentage = 33
    max_unavailable = 1
  }

  # Force node group update when EKS AMI version changes
  force_update_version = true

  # Apply labels to each EC2 instance for easier scheduling and management in Kubernetes
  labels = {
    "env"  = var.environment_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly
  ]

  tags = {
    Name    = "${var.project}-${var.env}-node-group"
    Env     = var.env
    Project = var.project
  }
}
