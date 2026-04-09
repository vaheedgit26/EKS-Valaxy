# NAT-INSTANCE Module Calling
module "nat_instance" {
  source = "git::https://github.com/vaheedgithubac/Infra//modules/nat_instance"
  #depends_on = [module.vpc]

  vpc_id                                  = data.aws_ssm_parameter.vpc_id.value
  vpc_cidr                                = data.aws_ssm_parameter.vpc_cidr.value
  ami_id                                  = var.ami_id          #"ami-0ddfba243cbee3768" 
  public_key_name                         = var.public_key_name #"mumbai-1"
  public_subnet_ID_to_launch_nat_instance = local.public_subnet_ids[0]
  public_subnet_cidr                      = local.public_subnet_cidr  # for private instance sg purpose
  private_subnet_cidr                     = local.private_subnet_cidr # for database instance sg purpose
  # private_subnet_ids                      = local.private_subnet_ids #module.vpc.private_subnet_ids 
  remote_ip_to_connect_nat_instance = "${var.remote_ip_to_connect_nat_instance}/32"

  is_nat_instance = true

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags

}
