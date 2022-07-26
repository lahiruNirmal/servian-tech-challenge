resource "aws_subnet" "application-subnet" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.0/28"

  tags = {
    Name = "application-subnet"
    Organization = "Servian"
  }
}

resource "aws_subnet" "db-subnet" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.16/29"

  tags = {
    Name = "db-subnet"
    Organization = "Servian"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.24/29"

  tags = {
    Name = "public-subnet"
    Organization = "Servian"
  }
}