# Security Group for Bastion Host
module "bastion_sg" {
  source = "git::https://github.com/vaheedgit26/Infra.git//modules/sg"
  project_name = var.project_name
  env = var.env
  vpc_id = module.vpc.vpc_id
  sg_name = "bastion_sg"
  sg_description = "Bastion Instance Security Group"
  common_tags = local.common_tags
}

resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id    # aws_security_group.sg_nat_instance.id
}
