variable "db_secret" {
  type = map(string)
}

variable "lb_sg_id" {
  description = "LB security group ID"
}

variable "app_subnet_ids" {
  description = "Application subnet IDs"
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
}

variable "vpc_id" {
  description = "VPC ID"
}
