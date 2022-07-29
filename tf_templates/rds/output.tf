output "db_password" {
  value = random_string.postgres-db-password.result
}

output "db_username" {
  value = aws_rds_cluster.db.master_username
}

output "rds_endpoint" {
  value = aws_rds_cluster.db.endpoint
}

output "rds_port" {
  value = aws_rds_cluster.db.port
}

# output "db_password" {
#   value = "jklajdk"
# }

# output "db_username" {
#   value = "lahiie"
# }

# output "rds_endpoint" {
#   value = "jskkllks"
# }

# output "rds_port" {
#   value = "5434"
# }