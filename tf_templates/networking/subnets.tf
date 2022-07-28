# Public layer subnets: public-subnet-1, public-subnet-2
# Application layer subnets: application-subnet-1, application-subnet-2
# DB layer subnets:db-subnet-1, db-subnet-2

# In each layer, availability zones a and b are selected from the selected region for each subnet respectively

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.tech-challenge.id
  cidr_block              = "10.0.1.0/28"
  availability_zone       = local.zone_a
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.tech-challenge.id
  cidr_block              = "10.0.1.16/28"
  availability_zone       = local.zone_b
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "application-subnet-1" {
  vpc_id            = aws_vpc.tech-challenge.id
  cidr_block        = "10.0.1.32/28"
  availability_zone = local.zone_a

  tags = {
    Name = "application-subnet-1"
  }
}

resource "aws_subnet" "application-subnet-2" {
  vpc_id            = aws_vpc.tech-challenge.id
  cidr_block        = "10.0.1.48/28"
  availability_zone = local.zone_b
  tags = {
    Name = "application-subnet-2"
  }
}

resource "aws_subnet" "db-subnet-1" {
  vpc_id            = aws_vpc.tech-challenge.id
  cidr_block        = "10.0.1.64/28"
  availability_zone = local.zone_a

  tags = {
    Name = "db-subnet-1"
  }
}

resource "aws_subnet" "db-subnet-2" {
  vpc_id            = aws_vpc.tech-challenge.id
  cidr_block        = "10.0.1.80/28"
  availability_zone = local.zone_b

  tags = {
    Name = "db-subnet-2"
  }
}

