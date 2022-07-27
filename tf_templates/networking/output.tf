output "db_sg_id" {
  value = aws_security_group.db-sg.id
}

output "lb_sg_id" {
  value = aws_security_group.lb-sg.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public-subnet-2.id
}

output "app_subnet_1_id" {
  value = aws_subnet.application-subnet-1.id
}

output "app_subnet_2_id" {
  value = aws_subnet.application-subnet-2.id
}

output "db_subnet_1_id" {
  value = aws_subnet.db-subnet-1.id
}

output "db_subnet_2_id" {
  value = aws_subnet.db-subnet-2.id
}

output "vpc_id" {
  value = aws_vpc.tech-challenge.id
}