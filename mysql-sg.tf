resource "aws_security_group" "ashiq_mysql_sg" {
  name        = "ashiq_mysql_sg"
  description = "Allow mysql inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.ashiq_vpc.id

  tags = {
    Name = "ashiq_mysql_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_ipv4" {
  security_group_id = aws_security_group.ashiq_mysql_sg.id
  cidr_ipv4         = "10.0.0.0/24"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_mysql" {
  security_group_id = aws_security_group.ashiq_mysql_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
