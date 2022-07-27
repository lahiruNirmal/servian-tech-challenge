resource "aws_vpc" "tech-challenge" {
  cidr_block       = "10.0.1.0/27"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "tech-challenge-vpc"
    Organization = "Servian"
  }
}