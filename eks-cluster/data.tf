locals {
  environment = var.environment_name
  owners = var.business_division
  name = "${local.owners}-${local.environment}"
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}