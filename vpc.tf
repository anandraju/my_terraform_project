resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  enable_classiclink   = "false"


  tags = {
    Name        = "main"
    Environment = "${terraform.workspace}"
  }
}

