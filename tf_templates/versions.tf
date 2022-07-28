
# Set versions to be used in Terrafrom and Terrafrom provider for AWS.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23.0"
    }
  }
  required_version = "~> 1.0"
}


provider "aws" {
  region = var.region
}
