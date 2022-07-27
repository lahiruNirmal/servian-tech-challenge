resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tech-challenge.id

  tags = {
    Name = "tech-challenge-igw"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "tech-challenge-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}