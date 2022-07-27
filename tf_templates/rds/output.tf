output "db_password" {
  value = random_string.postgres-db-password.result
}

output "db_username" {
  value = aws_db_instance.db.username
}

output "rds_endpoint" {
  value = aws_db_instance.db.address
}

output "rds_port" {
  value = aws_db_instance.db.port
}