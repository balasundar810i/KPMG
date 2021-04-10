resource "aws_security_group" "elb_sg" {
  description = "Load Balancer Security Group"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "web_sg" {
  description = "Web Server Security Group"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "app_sg" {
  description = "Application Security Group"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "db_sg" {
  description = "Database Security Group"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "in_web_from_elb" {
  type                     = "ingress"
  description              = "Allow inbound traffic on port 80 from ELB Security Group"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "in_app_from_web" {
  type                     = "ingress"
  description              = "Allow inbound traffic on port 80 from Web Security Group"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "in__db_from_app" {
  type                     = "ingress"
  description              = "Allow inbound traffic on port 1433 from App Security Group"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "out_http_app" {
  type              = "egress"
  description       = "Allow TCP internet traffic egress from app layer"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}


resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [ "aws_subnet.public_subnet.id" ]

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "main"
  }
}