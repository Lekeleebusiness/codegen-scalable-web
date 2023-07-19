resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-Public-Route-Table"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_route.id
}