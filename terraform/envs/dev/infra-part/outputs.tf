output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID used by EKS and other services"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Public subnets for ALB, NLB, etc."
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Private subnets for EKS worker nodes"
}

output "database_subnet_ids" {
  value       = module.vpc.database_subnet_ids
  description = "Database subnets for RDS"
}

output "bastion_host_sg_id" {
  value       = module.bastion_sg.sg_id
  description = "Bastion host security group id"
}

