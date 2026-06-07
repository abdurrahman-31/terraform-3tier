resource "aws_db_subnet_group" "ashiq_subnet_group" {
  name       = "shiq_subnet_group"
  subnet_ids = [aws_subnet.ashiq_private_subnet_a.id, aws_subnet.ashiq_private_subnet_b.id]

  tags = {
    Name = "ashiq_subnet_group"
  }
}
