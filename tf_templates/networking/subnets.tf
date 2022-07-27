resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.0/28"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.16/28"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "application-subnet-1" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.32/28"
  availability_zone = "us-east-1a"

  tags = {
    Name = "application-subnet-1"
  }
}

resource "aws_subnet" "application-subnet-2" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.48/28"
  availability_zone = "us-east-1b"

  tags = {
    Name = "application-subnet-2"
  }
}

resource "aws_subnet" "db-subnet-1" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.64/28"
  availability_zone = "us-east-1a"

  tags = {
    Name = "db-subnet-1"
  }
}

resource "aws_subnet" "db-subnet-2" {
  vpc_id     = aws_vpc.tech-challenge.id
  cidr_block = "10.0.1.80/28"
  availability_zone = "us-east-1b"

  tags = {
    Name = "db-subnet-2"
  }
}

