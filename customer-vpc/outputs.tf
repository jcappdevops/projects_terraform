output "vpc_id" {
  value       = module.customer-vpc.vpc_id
  description = "VPC ID used by EKS and other services"
}

output "private_subnet_ids" {
  value       = module.customer-vpc.private_subnet_ids
  description = "Private subnets for EKS worker nodes"
}

output "public_subnet_ids" {
  value       = module.customer-vpc.public_subnet_ids
  description = "Public subnets for ALB, NLB, etc."
}

output "public_subnet_map" {
  value       = module.customer-vpc.public_subnet_map
  description = "Public subnets for ALB, NLB, etc."
}

