resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-route-table"
  }
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "database_1" {
  subnet_id      = aws_subnet.database_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "database_2" {
  subnet_id      = aws_subnet.database_2.id
  route_table_id = aws_route_table.private_route.id
}