# variable "db_name" {
#   default = "app"
#   description = "Name of the database"
# }

variable "username" {
  default     = "postgres"
  description = "username of the database"
}

variable "db_identifier" {
  default     = "tech-challenge-db"
  description = "Name of the RDS instance of the tech-challenge db"
}

variable "db_security_group_id" {
  description = "DB security group ID"
}

variable "db_subnet_ids" {
  description = "Database subnet ID"
  type        = list(string)
}

variable "db_engine" {
  default     = "postgres"
  description = "DB engine to be used"
}

variable "db_engine_version" {
  default     = "10.17"
  description = "DB engine version to be used"
}

variable "db_instace_class" {
  default     = "db.t3.micro"
  description = "Instance class type of the RDS instances"
}

variable "number_of_read_replicas" {
  default     = 1
  description = "Number of read replicas for DB"
}