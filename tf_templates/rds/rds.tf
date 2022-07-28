# DB master instance
resource "aws_db_instance" "db" {
  allocated_storage = 5
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instace_class
  # db_name                 = var.db_name
  identifier             = var.db_identifier
  username               = var.username
  password               = random_string.postgres-db-password.result
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = true

  tags = {
    "Name" = "tech-challenge-db-master"
  }
}

# DB read replicas
resource "aws_db_instance" "db-read-replica" {
  count               = var.number_of_read_replicas
  replicate_source_db = aws_db_instance.db.identifier
  identifier          = format("%s-%s", var.db_identifier, count.index)
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  instance_class      = var.db_instace_class
  # db_name                 = var.db_name
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = true

  tags = {
    "Name" = "tech-challenge-db-replica"
  }
}

# Generates a random password for RDS
resource "random_string" "postgres-db-password" {
  length  = 32
  upper   = true
  number  = true
  special = false
}

# The subnets to be used for DB instances 
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "tech-challenge db subnet group"
  }
}