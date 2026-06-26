# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Remote Backend 
  backend "s3" {
    bucket       = "tfstate-dev-us-east-1-dc1xse" # <-- Replace with your actual bucket name
    key          = "vpc/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}





# Provider Block
provider "aws" {
  region = var.aws_region
}


