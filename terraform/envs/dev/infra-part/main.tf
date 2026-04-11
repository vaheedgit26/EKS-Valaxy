# VPC-MODULE Calling
module "vpc" {
  source = "git::https://github.com/vaheedgit26/Infra//modules/vpc" # Give the path to VPC MODULE accordingly

  # All the counts should be same 
  azs_count             = 2
  public_subnet_count   = 2
  private_subnet_count  = 2
  database_subnet_count = 2

  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidr   = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidr  = ["10.100.11.0/24", "10.100.12.0/24"]
  database_subnet_cidr = ["10.100.31.0/24", "10.100.32.0/24"]

  project_name = var.project_name
  env          = var.env
  common_tags  = local.common_tags
}

# NAT-INSTANCE Module Calling
module "nat_instance" {
  source = "git::https://github.com/vaheedgit26/Infra//modules/nat_instance"
  # depends_on = [module.vpc]

  vpc_id                                  = module.vpc.vpc_id
  vpc_cidr                                = module.vpc.vpc_cidr
  ami_id                                  = "ami-0ddfba243cbee3768" 
  public_key_name                         = "mumbai-1"
  public_subnet_ID_to_launch_nat_instance = module.vpc.public_subnet_ids[0]
  public_subnet_cidr                      = module.vpc.public_subnet_cidr       # for private instance sg purpose
  private_subnet_cidr                     = module.vpc.private_subnet_cidr      # for database instance sg purpose
  # private_subnet_ids                      = local.private_subnet_ids #module.vpc.private_subnet_ids 
  remote_ip_to_connect_nat_instance       = "0.0.0.0/0"       # "${var.remote_ip_to_connect_nat_instance}/32"

  is_nat_instance = true
  is_eip_required = false

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags

}
