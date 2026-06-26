aws_region       = "us-east-1"
vpc_cidr         = "10.0.0.0/16"
environment_name = "dev-demo"
subnet_newbits   = 8

tags = {
  Terraform = "true"
  Project   = "retail-store"
  Owner     = "Kalyan Reddy Daida"
  Course    = "DevOps Real-world Implementation Project on AWS Cloud"
  Demo      = "VPC with Remote Backend Demo"
}