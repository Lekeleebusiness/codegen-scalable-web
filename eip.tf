resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.project_name}-${var.environment}-eip"
  }
}




