output "db_sg_id" {
  value = aws_security_group.db-sg.id
}

output "db_subnet_id" {
  value = aws_subnet.db-subnet.id
}