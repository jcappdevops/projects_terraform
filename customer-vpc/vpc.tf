module "customer-vpc" {
  source           = "./modules/vpc"
  aws_region       = var.aws_region
  environment_name = var.environment_name
  vpc_cidr         = var.vpc_cidr
  subnet_newbits   = var.subnet_newbits
  tags             = var.tags
}