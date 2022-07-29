resource "aws_security_group" "lb-sg" {
  name        = "lb-sg"
  description = "Load Balancer SG"
  vpc_id      = aws_vpc.tech-challenge.id

  tags = {
    Name = "Load Balancer SG"
  }
}

resource "aws_security_group" "app-sg" {
  name        = "application-sg"
  description = "Application SG"
  vpc_id      = aws_vpc.tech-challenge.id

  tags = {
    Name = "Application SG"
  }
}


resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Database SG"
  vpc_id      = aws_vpc.tech-challenge.id

  tags = {
    Name = "Database SG"
  }
}

resource "aws_security_group_rule" "https-rule" {
  type              = "ingress"
  to_port           = 443
  from_port         = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lb-sg.id
}

resource "aws_security_group_rule" "http-rule" {
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lb-sg.id
}

# resource "aws_security_group_rule" "application-https-rule" {
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 443
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.lb-sg.id
#   security_group_id        = aws_security_group.app-sg.id
# }

# resource "aws_security_group_rule" "application-http-rule" {
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 80
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.lb-sg.id
#   security_group_id        = aws_security_group.app-sg.id
# }

resource "aws_security_group_rule" "application-http-rule" {
  type                     = "ingress"
  to_port                  = 3000
  from_port                = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb-sg.id
  security_group_id        = aws_security_group.app-sg.id
}

resource "aws_security_group_rule" "db-rule" {
  type                     = "ingress"
  to_port                  = 5432
  from_port                = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app-sg.id
  security_group_id        = aws_security_group.db-sg.id
}

resource "aws_security_group_rule" "application-egress-rule" {
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-sg.id
}

resource "aws_security_group_rule" "lb-egress-rule" {
  type              = "egress"
  to_port           = 3000
  from_port         = 3000
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb-sg.id
}