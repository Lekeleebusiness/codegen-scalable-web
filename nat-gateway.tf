resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_1.id
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway"
  }
}