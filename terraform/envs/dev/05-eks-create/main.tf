data "aws_caller_identity" "current" {}

module "eks" {
  source = "../../modules/eks"

  project             = "pharma"
  env                 = "dev"
  cluster_version     = "1.33"
  cluster_subnet_ids  = module.vpc.private_subnet_ids
  node_instance_types = ["t3.small"]
  desired_capacity    = 3
  min_size            = 2
  max_size            = 4
}

module "rds" {
  source = "../../modules/rds"

  project               = "pharma"
  env                   = "dev"
  subnet_ids            = module.vpc.private_rds_subnet_ids
  vpc_id                = module.vpc.vpc_id
  eks_security_group_id = module.eks.cluster_security_group_id
  db_name               = "pharmadb"
  db_username           = "pharmaadmin"
  db_password           = var.db_password
}

module "ecr" {
  source = "../../modules/ecr"

  project = "pharma"
  env     = "dev"
  repositories = [
    "api-gateway",
    "auth-service",
    "pharma-ui",
    "notification-service",
    "drug-catalog-service"
  ]
}

module "iam" {
  source = "../../modules/iam"

  project           = "pharma"
  env               = "dev"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  aws_account_id    = data.aws_caller_identity.current.account_id
}

module "secrets_manager" {
  source = "../../modules/secrets-manager"

  project     = "pharma"
  env         = "dev"
  db_username = "pharmaadmin"
  db_password = var.db_password
  jwt_secret  = var.jwt_secret
}
