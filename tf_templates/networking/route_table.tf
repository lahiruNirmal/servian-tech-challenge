resource "aws_route_table" "application-route-table" {
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
    Name = "application-route-table"
    Organization = "Servian"
  }
}

resource "aws_route_table" "db-route-table" {
  vpc_id = aws_vpc.tech-challenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "db-route-table"
    Organization = "Servian"
  }
}

resource "aws_route_table_association" "application-route-table-association" {
  subnet_id      = aws_subnet.application-subnet.id
  route_table_id = aws_route_table.application-route-table.id
}

resource "aws_route_table_association" "db-route-table-association" {
  subnet_id      = aws_subnet.db-subnet.id
  route_table_id = aws_route_table.db-route-table.id
}