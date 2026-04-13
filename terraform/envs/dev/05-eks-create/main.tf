data "aws_caller_identity" "current" {}

module "eks" {
  source = "../../../modules/eks"

  project             = var.project  # "pharma"
  env                 = var.env      # "dev"

  cluster_version                 = "1.33"
  cluster_subnet_ids              = [data.terraform_remote_state.vpc.private_subnet_ids]
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  eks_cluster_security_group_ids  = [data.terraform_remote_state.vpc.bastion_host_sg_id]  # This is additional cluster SG and the default cluster SG is intact

  node_subnet_ids     = data.terraform_remote_state.vpc.private_subnet_ids
  node_instance_types = ["t3.small"]
  node_capacity_type  = "SPOT"
  node_addl_sg_ids    = [data.terraform_remote_state.vpc.bastion_host_sg_id]              # This is additional cluster SG and the default cluster SG is intact
  node_ssh_public_key = "us-east-1"

  desired_capacity    = 3
  min_size            = 2
  max_size            = 4
}

module "rds" {
  source = "../../../modules/rds"

  project               = var.project  # "pharma"
  env                   = var.env      # "dev"
  subnet_ids            = [data.terraform_remote_state.vpc.database_subnet_ids]
  vpc_id                = data.terraform_remote_state.vpc.vpc_id
  # eks_security_group_id = module.eks.cluster_security_group_id
  rds_allowed_security_group_ids = [module.eks.cluster_security_group_id, data.terraform_remote_state.vpc.bastion_host_sg_id]
  db_name               = "pharmadb"
  db_username           = "pharmaadmin"
  db_password           = var.db_password
}

module "ecr" {
  source = "../../../modules/ecr"

  project = var.project  # "pharma"
  env     = var.env      # "dev"
  repositories = [
    "api-gateway",
    "auth-service",
    "pharma-ui",
    "notification-service",
    "drug-catalog-service"
  ]
}

module "iam" {
  source = "../../../modules/iam"

  project           = var.project  # "pharma"
  env               = var.env      # "dev"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  aws_account_id    = data.aws_caller_identity.current.account_id
}

module "secrets_manager" {
  source = "../../../modules/secrets-manager"

  project     = var.project  # "pharma"
  env         = var.env      # "dev"
  db_username = "pharmaadmin"
  db_password = var.db_password
  jwt_secret  = var.jwt_secret
}
