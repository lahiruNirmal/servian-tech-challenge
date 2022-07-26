resource "aws_route_table" "public-subnet-route-table" {
  vpc_id = aws_vpc.tech-challenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-subnet-route-table"
    Organization = "Servian"
  }
}

resource "aws_route_table" "private-subnet-route-table" {
  vpc_id = aws_vpc.tech-challenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-subnet-route-table"
    Organization = "Servian"
  }
}

resource "aws_route_table_association" "public-subnet-route-table-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-subnet-route-table.id
}

resource "aws_route_table_association" "application-subnet-route-table-association" {
  subnet_id      = aws_subnet.application-subnet.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}