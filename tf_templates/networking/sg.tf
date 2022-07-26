resource "aws_security_group" "lb-sg" {
  name        = "Load Balancer SG"
  description = "Load Balancer SG"
  vpc_id      = aws_vpc.tech-challenge.id

  tags = {
    Name = "Load Balancer SG"
    Organization = "Servian"
  }
}

resource "aws_security_group" "application-sg" {
  name        = "Application SG"
  description = "Application SG"
  vpc_id      = aws_vpc.tech-challenge.id

  tags = {
    Name = "Application SG"
    Organization = "Servian"
  }
}


resource "aws_security_group" "db-sg" {
  name        = "Database SG"
  description = "Database SG"
  vpc_id      = aws_vpc.tech-challenge.id

  tags = {
    Name = "Database SG"
    Organization = "Servian"
  }
}

resource "aws_security_group_rule" "https-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lb-sg.id
}

resource "aws_security_group_rule" "http-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lb-sg.id
}

resource "aws_security_group_rule" "application-https-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.lb-sg.id
  security_group_id = aws_security_group.application-sg.id
}

resource "aws_security_group_rule" "application-http-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.lb-sg.id
  security_group_id = aws_security_group.application-sg.id
}

resource "aws_security_group_rule" "db-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 5432
  protocol          = "tcp"
  source_security_group_id = aws_security_group.application-sg.id
  security_group_id = aws_security_group.db-sg.id
}
