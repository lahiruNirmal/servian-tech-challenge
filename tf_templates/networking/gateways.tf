resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tech-challenge.id

  tags = {
    Name = "tech-challenge-igw"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "tech-challenge-ngw"
  }

  depends_on = [aws_internet_gateway.igw]
}