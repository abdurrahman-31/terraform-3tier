resource "aws_db_instance" "ashiq_rds" {
  allocated_storage      = 10
  db_name                = "terraform_db"
  engine                 = "mysql"
  engine_version         = "8.4.8"
  instance_class         = "db.t4g.micro"
  username               = "admin"
  password               = "admin123"
  parameter_group_name   = "default.mysql8.4"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.ashiq_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ashiq_mysql_sg.id]

  tags = {
    Name = "ashiq_rds"
  }
}
