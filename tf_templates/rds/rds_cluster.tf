# resource "aws_rds_cluster" "db" {
#   cluster_identifier           = var.db_identifier
#   availability_zones           = var.db_az_zonnes
#   engine                       = var.db_engine
#   engine_version               = var.db_engine_version
#   db_cluster_instance_class    = var.db_instace_class
#   allocated_storage            = 10
#   storage_type                 = "io1"
#   iops                         = 1000
#   backup_retention_period      = 1
#   preferred_maintenance_window = "Mon:00:00-Mon:03:00"
#   preferred_backup_window      = "09:46-10:16"
#   master_username              = var.username
#   master_password              = random_string.postgres-db-password.result
#   skip_final_snapshot          = true
#   db_subnet_group_name         = aws_db_subnet_group.db-subnet-group.name
#   vpc_security_group_ids       = [var.db_security_group_id]

#   tags = {
#     "Name" = "tech-challenge-db-master"
#   }
# }

# # Generates a random password for RDS
# resource "random_string" "postgres-db-password" {
#   length  = 32
#   upper   = true
#   numeric = true
#   special = false
# }

# # The subnets to be used for DB instances 
# resource "aws_db_subnet_group" "db-subnet-group" {
#   name       = "db-subnet-group"
#   subnet_ids = var.db_subnet_ids

#   tags = {
#     Name = "tech-challenge db subnet group"
#   }
# }