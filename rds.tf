
resource "aws_db_subnet_group" "CodeGen_db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.database_1.id, aws_subnet.database_2.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  }
}

resource "aws_db_instance" "quandoo" {
  identifier                = var.identifier
  engine                    = var.engine
  engine_version            = var.engine-version
  instance_class            = var.instance-class
  db_name                   = var.db-name
  username                  = var.username
  password                  = jsondecode(data.aws_secretsmanager_secret_version.rds_password.secret_string)["password"]
  allocated_storage         = var.allocated_storage 
  storage_type              = var.storage_type
  backup_retention_period   = var.backup_retention_period
  db_subnet_group_name      = aws_db_subnet_group.CodeGen_db_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.CodeGen_database_sg.id]
  multi_az                  = true
  skip_final_snapshot       = true


  tags = {
    Name = "${var.project_name}-${var.environment}-rds"
  }

}
