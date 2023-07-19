# Lookup Ubuntu AMI Image
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}

## Launch Template and ASG Resources

resource "aws_launch_template" "launch_template" {
  name          = "${var.project_name}-${var.environment}-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-asg-ec2"
    }
  }
  user_data = base64encode("${var.ec2_user_data}")
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  target_group_arns   = [aws_lb_target_group.target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}