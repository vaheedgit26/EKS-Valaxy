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
  ami_id                                  = var.ami_id            #"ami-0ddfba243cbee3768" 
  public_key_name                         = var.public_key_name   #"mumbai-1"
  instance_type                           = "t3.micro"            # var.instance_type

  public_subnet_ID_to_launch_nat_instance = module.vpc.public_subnet_ids[0]
  public_subnet_cidr                      = module.vpc.public_subnet_cidr       # for private instance sg purpose
  private_subnet_cidr                     = module.vpc.private_subnet_cidr      # for database instance sg purpose
  # private_subnet_ids                    = local.private_subnet_ids #module.vpc.private_subnet_ids 

  root_volume_size                        = 8       # ( default: 8 )
  private_route_table_id                  = module.vpc.private_route_table_id
  database_route_table_id                 = module.vpc.database_route_table_id

  remote_ip_to_connect_nat_instance       = "0.0.0.0/0"       # "${var.remote_ip_to_connect_nat_instance}/32"

  # is_nat_instance = true
  is_eip_required = false

  project_name = var.project_name
  env          = var.env
  common_tags  = local.common_tags
}

# Security Group for Bastion Host
module "bastion_sg" {
  source = "git::https://github.com/vaheedgit26/Infra.git//modules/sg"
  project_name = var.project_name
  env = var.env
  vpc_id = var.vpc_id
  sg_name = "bastion_sg"
  sg_description = "Bastion Instance Security Group"
  common_tags = var.common_tags
}

# Bastion Host
module "ec2" {
  source = "git::https://github.com/vaheedgit26/Infra.git//modules/ec2"

  ami_id                      = var.ami_id                       # "ami-0ddfba243cbee3768"
  public_key_name             = var.public_key_name              # "mumbai-1"
  instance_type               = "t3.micro"                       # var.instance_type
  sg_ids                      = [module.bastion_sg.sg_id]
  subnet_id                   = module.vpc.public_subnet_ids[0]  # "subnet-088e8443a70102e2a" #1a
  associate_public_ip_address = true

  what_type_instance          = "bastion"

  # is_nat_instance             = var.is_nat_instance  # creates NAT instance if true
  # is_eip_required             = var.is_eip_required
  # user_data                   = file("${path.module}/nat_user_data.sh")

  project_name                = var.project_name
  env                         = var.env
  common_tags                 = var.common_tags
}
