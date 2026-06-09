resource "aws_instance" "web_server" {
  ami                    = "ami-0db56f446d44f2f09"
  instance_type          = "t3.micro"
  key_name               = "mumbai key"
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
  subnet_id              = aws_subnet.ashiq_public_subnet.id
  vpc_security_group_ids = [aws_security_group.ashiq_sg.id]
  tags = {
    Name = "terraform_web_server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo dnf module enable php:8.2 -y
              sudo dnf install -y php php-cli php-mysqlnd php-fpm php-gd php-xml php-mbstring
              sudo dnf install -y mariadb-server
              sudo yum install httpd -y
              sudo yum install git -y
              sudo git clone https://github.com/WordPress/WordPress.git /var/www/html
              sudo chown -R apache /var/www/html
              sudo systemctl start httpd
              EOF
}
