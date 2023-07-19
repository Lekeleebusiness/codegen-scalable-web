# create security group for the application load balancer
resource "aws_security_group" "alb_security_group" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "enable http access on port 80"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  }
}


resource "aws_security_group" "asg_security_group" {
  name        = "${var.project_name}-${var.environment}-asg-sg"
  description = "ASG Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-asg-sg"
  }
}

resource "aws_security_group" "CodeGen_database_sg" {
  name        = "${var.project_name}-${var.environment}-database-sg"
  vpc_id      = aws_vpc.vpc.id
  description = "Database Security Group"
  
  ingress {
    description      = "cluster acess to database"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [aws_security_group.asg_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    Name = "${var.project_name}-${var.environment}-database-sg" }  
}