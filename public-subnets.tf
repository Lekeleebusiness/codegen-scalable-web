resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_1_cidr_block
  availability_zone = data.aws_availability_zones.us_east_1.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-Public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_2_cidr_block
  availability_zone = data.aws_availability_zones.us_east_1.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-Public-subnet-2"
    
  }
}





