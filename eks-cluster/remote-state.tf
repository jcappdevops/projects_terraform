data "terraform_remote_state" "customer-vpc"{
    backend = "s3"
    config = {
       bucket = "tfstate-dev-us-east-1-dc1xse"
       key =  "vpc/dev/terraform.tfstate"
       region = var.aws_region
    }
}

# --------------------------------------------------------------------
# Output the VPC ID from the remote VPC state
# --------------------------------------------------------------------
output "vpc_id" {
   value = data.terraform_remote_state.customer-vpc.outputs.vpc_id
}

# --------------------------------------------------------------------
# Output the list of private subnets from the VPC
# --------------------------------------------------------------------

output "private_subnet_ids" {
   value = data.terraform_remote_state.customer-vpc.outputs.private_subnet_ids
}


# --------------------------------------------------------------------
# Output the list of public subnets from the VPC
# --------------------------------------------------------------------

output "public_subnet_ids" {
   value = data.terraform_remote_state.customer-vpc.outputs.public_subnet_ids
}