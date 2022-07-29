# DB master instance
resource "aws_db_instance" "db" {
  allocated_storage        = 5
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  instance_class           = var.db_instace_class
  identifier               = var.db_identifier
  username                 = var.username
  db_subnet_group_name     = aws_db_subnet_group.db-subnet-group.name
  password                 = random_string.postgres-db-password.result
  backup_retention_period  = 1
  backup_window            = "09:46-10:16"
  maintenance_window       = "Mon:00:00-Mon:03:00"
  delete_automated_backups = true
  vpc_security_group_ids   = [var.db_security_group_id]
  skip_final_snapshot      = true
  publicly_accessible      = false
  multi_az                 = true
  availability_zone        = var.db_az_zones[2]
  kms_key_id               = aws_kms_key.db-encryption-key.arn

  tags = {
    "Name" = "tech-challenge-db-master"
  }
}

# DB read replicas
resource "aws_db_instance" "db-read-replica" {
  count                  = var.number_of_read_replicas
  replicate_source_db    = aws_db_instance.db.identifier
  identifier             = format("%s-%s", var.db_identifier, count.index)
  instance_class         = var.db_instace_class
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot    = true
  multi_az               = true
  kms_key_id             = aws_kms_key.db-encryption-key.arn
  availability_zone      = var.db_az_zones[count.index]

  tags = {
    "Name" = "tech-challenge-db-replica"
  }
}

# Generates a random password for RDS
resource "random_string" "postgres-db-password" {
  length  = 32
  upper   = true
  numeric = true
  special = false
}

# The subnets to be used for DB instances 
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "tech-challenge db subnet group"
  }
}

