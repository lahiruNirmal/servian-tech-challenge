resource "aws_db_instance" "db" {
  allocated_storage    = 5
  engine               = "postgres"
  engine_version       = "9.6"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  identifier           = var.db_identifier 
  username             = var.username
  password             = random_string.postgres-db-password.result
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az = true
}

resource "aws_db_instance" "db-read-replica" {
  count                = var.number_of_read_replicas 
  replicate_source_db  = aws_db_instance.db.identifier
  identifier_prefix    = local.db_identifier_read_replica_prefix
  engine               = "postgres"
  engine_version       = "9.6"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az = true
}

resource "random_string" "postgres-db-password" {
  length  = 32
  upper   = true
  number  = true
  special = false
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "tech-challenge db subnet group"
  }
}