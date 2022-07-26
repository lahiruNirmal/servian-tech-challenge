resource "aws_subnet" "application-subnet" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.0/27"

  tags = {
    Name = "application"
    Organization = "Servian"
  }
}

resource "aws_subnet" "db-subnet" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.16/27"

  tags = {
    Name = "db"
    Organization = "Servian"
  }
}