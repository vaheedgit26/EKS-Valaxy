data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.env}/vpc_id"
  #depends_on = [module.vpc]
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/${var.project_name}/${var.env}/vpc_cidr"
  #depends_on = [module.vpc]
}

data "aws_ssm_parameter" "public_subnet_cidr" {
  name = "/${var.project_name}/${var.env}/public_subnet_cidr"
  #depends_on = [module.vpc]
}

data "aws_ssm_parameter" "private_subnet_cidr" {
  name = "/${var.project_name}/${var.env}/private_subnet_cidr"
  #depends_on = [module.vpc]
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.env}/public_subnet_ids"
  #depends_on = [module.vpc]
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.env}/private_subnet_ids"
  #depends_on = [module.vpc]
}
