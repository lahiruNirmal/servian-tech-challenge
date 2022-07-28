variable "db_secret" {
  type = map(string)
}

variable "lb_sg_id" {
  description = "LB security group ID"
}

variable "app_instance_class" {
  default     = "t2.micro"
  description = "Instance class for the application VMs"
}

variable "app_sg_id" {
  description = "Application security group ID"
}

variable "app_subnet_ids" {
  description = "Application subnet IDs"
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "db_secret_name" {
  default = "db/tech_challenge_secret"
}

variable "region" {
  description = "Region of the deployment"
}

variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0cff7528ff583bf9a"
    "us-west-2" = "ami-098e42ae54c764c35"
  }
}