# EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project}-${var.env}-node-group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.node_subnet_ids
  instance_types  = var.node_instance_types
  capacity_type   = var.node_capacity_type
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

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_AmazonEBSCSIDriverPolicy
  ]

  tags = {
    Name    = "${var.project}-${var.env}-node-group"
    Env     = var.env
    Project = var.project
  }
}
