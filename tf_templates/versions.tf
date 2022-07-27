terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.23.0"
    }
  }
  required_version = "~> 1.0"
}

provider "aws" {
  region = var.region
  access_key = "AKIATF3PPMY5H7GRAH36"
  secret_key = "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"
}
