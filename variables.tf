variable "region" {
  default = "us-east-1"
}

#project tag details
variable "project_name" {
  description = "project name"
  default = "CodeGen"
}

variable "environment" {
  description = "environment"
  default = "dev"
}

#networking
variable "vpc_cidr_block" {
  description = "cidr block for the VPC"
  default = "10.0.0.0/16"
}

variable "public_1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_2_cidr_block" {
  default = "10.0.2.0/24"
}

variable "private_1_cidr_block" {
  default = "10.0.3.0/24"
}

variable "private_2_cidr_block" {
  default = "10.0.4.0/24"
}

variable "database_cidr_block_1" {
  default = "10.0.5.0/24"
}

variable "database_cidr_block_2" {
  default = "10.0.6.0/24"
}


# Launch Template and ASG Variables
variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_user_data" {
  description = "User data shell script for Apache installation"
  type        = string
  default     = <<EOF
#!/bin/bash

# Install Apache on Ubuntu

sudo apt update -y
sudo apt install -y apache2


sudo cat > /var/www/html/index.html << EOF
<html>
<head>
  <title> Apache on Ubuntu </title>
</head>
<body>
  <p> Apache was installed using Terraform!
</body>
</html>
EOF
}

#RDS 
variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine-version" {
  type    = string
  default = "14.7"
}

variable "instance-class" {
  type    = string
  default = "db.t3.micro"
}

variable "db-name" {
  type    = string
  default = "mydatabase"
}

variable "username" {
  type    = string
  default = "postgres"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "identifier" {
  default = "codegen"
}

data "aws_secretsmanager_secret" "rds_password"{
    name = "codegen/rds/password"
}

data "aws_secretsmanager_secret_version" "rds_password"{
    secret_id = data.aws_secretsmanager_secret.rds_password.id
}

