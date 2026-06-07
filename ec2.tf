resource "aws_instance" "web_server" {
  ami           = "ami-0685bcc683dadb6b9"
  instance_type = "t3.micro"
  key_name      = "mumbai key"
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
  subnet_id              = aws_subnet.ashiq_public_subnet.id
  vpc_security_group_ids = [aws_security_group.ashiq_sg.id]
  tags = {
    Name = "terraform_web_server"
  }
}
