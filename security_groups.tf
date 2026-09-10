resource "aws_security_group" "jump" {
  name        = "jump"
  description = "jump host SG"
  vpc_id      = aws_vpc.main.id

  #ingress {
  #  description      = "inbound ssh"
  #  from_port        = 22
  #  to_port          = 22
  #  protocol         = "tcp"
  #  cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  #}
  ingress {
    description      = "wireguard"
    from_port        = 31337
    to_port          = 31337
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ "Name" = "${var.base_name}-jump-sg" }, var.common_tags)
}

resource "aws_security_group" "proxy" {
  name        = "proxy"
  description = "proxy services"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "proxy service inbound"
    from_port        = 3128
    to_port          = 3128
    protocol         = "tcp"
    cidr_blocks      = ["10.13.37.0/24"]
    ipv6_cidr_blocks = ["2406:da1c:c99:9100::/56"]
  }
  egress {
    description      = "outbound to internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ "Name" = "${var.base_name}-proxy-sg" }, var.common_tags)
}

resource "aws_security_group" "sharedServices" {
  name        = "sharedServices"
  description = "Shared Services SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "ssh from jump host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump.id]
  }

  egress {
    description     = "http proxy to the proxy SG"
    from_port       = 3128
    to_port         = 3128
    protocol        = "tcp"
    security_groups = [aws_security_group.proxy.id]
  }

  tags = merge({ "Name" = "${var.base_name}-sharedServices" }, var.common_tags)
}

resource "aws_security_group" "email" {
  name        = "email services"
  description = "email services"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "smtp inbound 25"
    from_port        = 25
    to_port          = 25
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description     = "imap inbound 25 from jump/vpn"
    from_port       = 993
    to_port         = 993
    protocol        = "tcp"
    security_groups = [aws_security_group.jump.id]
  }
  ingress {
    description     = "imap inbound 1337 from jump/vpn"
    from_port       = 1337
    to_port         = 1337
    protocol        = "tcp"
    security_groups = [aws_security_group.jump.id]
  }
  egress {
    description      = "smtp outbound 25"
    from_port        = 25
    to_port          = 25
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "smtp outbound 465"
    from_port        = 465
    to_port          = 465
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "smtp outbound 587"
    from_port        = 587
    to_port          = 587
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ "Name" = "email" }, var.common_tags)
}

resource "aws_security_group" "dns" {
  name        = "dns services"
  description = "dns services"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "dns inbound udp"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "dns inbound tcp"
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description     = "dns zone transfer"
    from_port       = 53
    to_port         = 53
    protocol        = "udp"
    security_groups = [aws_security_group.jump.id]
  }
  egress {
    description     = "dns zone transfer"
    from_port       = 53
    to_port         = 53
    protocol        = "tcp"
    security_groups = [aws_security_group.jump.id]
  }
  tags = merge({ "Name" = "${var.base_name}-dns" }, var.common_tags)
}
