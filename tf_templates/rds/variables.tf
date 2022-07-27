variable "db_name" {
  default = "app"
  description = "Name of the database"
}

variable "username" {
  default = "postgres"
  description = "username of the database"
}

variable "db_identifier" {
  default = "tech-challenge-db"
  description = "Name of the RDS instance of the tech-challenge db"
}

variable "db_security_group_id" {
  description = "DB security group ID"
}

variable "db_subnet_ids" {
  description = "Database subnet ID"
}