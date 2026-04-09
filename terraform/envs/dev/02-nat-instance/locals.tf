locals {
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  # private_subnet_ids  = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  public_subnet_cidr  = split(",", data.aws_ssm_parameter.public_subnet_cidr.value)
  private_subnet_cidr = split(",", data.aws_ssm_parameter.private_subnet_cidr.value)
}
