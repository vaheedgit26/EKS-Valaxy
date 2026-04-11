# NAT-INSTANCE Module Calling
module "nat_instance" {
  source = "git::https://github.com/vaheedgithubac/Infra//modules/nat_instance"
  #depends_on = [module.vpc]

  vpc_id                                  = var.vpc_id
  vpc_cidr                                = var.vpc_cidr
  ami_id                                  = "ami-0ddfba243cbee3768" 
  public_key_name                         = "mumbai-1"
  public_subnet_ID_to_launch_nat_instance = var.public_subnet_ids[0]
  public_subnet_cidr                      = var.public_subnet_cidr  # for private instance sg purpose
  private_subnet_cidr                     = var..private_subnet_cidr # for database instance sg purpose
  # private_subnet_ids                      = local.private_subnet_ids #module.vpc.private_subnet_ids 
  remote_ip_to_connect_nat_instance = "${var.remote_ip_to_connect_nat_instance}/32"

  is_nat_instance = true
  is_eip_required = false

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags

}
