# Route table to be used by public subnets
resource "aws_route_table" "public-subnet-route-table" {
  vpc_id = aws_vpc.tech-challenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-subnet-route-table"
  }
}

# Route table to be used by private subnets
resource "aws_route_table" "private-subnet-route-table" {
  vpc_id = aws_vpc.tech-challenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-subnet-route-table"
  }
}

# Route table associations with public subnets
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-subnet-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-subnet-route-table.id
}

#Route table associations with private subnets
resource "aws_route_table_association" "application-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.application-subnet-1.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}

resource "aws_route_table_association" "application-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.application-subnet-2.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}

resource "aws_route_table_association" "db-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.db-subnet-1.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}

resource "aws_route_table_association" "db-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.db-subnet-2.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}

resource "aws_route_table_association" "db-subnet-3-route-table-association" {
  subnet_id      = aws_subnet.db-subnet-3.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}
