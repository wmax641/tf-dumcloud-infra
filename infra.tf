resource "aws_vpc" "main" {
  cidr_block                       = "10.13.37.0/24"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags                             = merge({ "Name" = var.base_name }, var.common_tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge({ "Name" = "${var.base_name}-igw" }, var.common_tags)
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = merge({ "Name" = "${var.base_name}-default_route-table" }, var.common_tags)
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_subnet" "subnet0" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
  tags            = merge({ "Name" = "${var.base_name}-subnet0" }, var.common_tags)
}
resource "aws_subnet" "subnet1" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 2, 1)
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)
  tags            = merge({ "Name" = "${var.base_name}-subnet1" }, var.common_tags)
}
resource "aws_subnet" "subnet2" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 2, 2)
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)
  tags            = merge({ "Name" = "${var.base_name}-subnet2" }, var.common_tags)
}
resource "aws_subnet" "subnet3" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 2, 3)
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 3)
  tags            = merge({ "Name" = "${var.base_name}-subnet3" }, var.common_tags)
}

resource "aws_network_acl" "nacl0" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }

  tags = merge({ "Name" = "${var.base_name}-nacl0" }, var.common_tags)
}

resource "aws_network_acl" "nacl1" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
    from_port       = 0
    to_port         = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
    from_port       = 0
    to_port         = 0
  }

  tags = merge({ "Name" = "${var.base_name}-nacl1" }, var.common_tags)
}

resource "aws_network_acl" "nacl2" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }

  tags = merge({ "Name" = "${var.base_name}-nacl2" }, var.common_tags)
}

resource "aws_network_acl" "nacl3" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, 2)
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)
    from_port       = 0
    to_port         = 0
  }
  egress {
    protocol   = "-1"
    rule_no    = 300
    action     = "allow"
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol        = "-1"
    rule_no         = 301
    action          = "allow"
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
    from_port       = 0
    to_port         = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, 2)
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol        = "-1"
    rule_no         = 201
    action          = "allow"
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)
    from_port       = 0
    to_port         = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 300
    action     = "allow"
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol        = "-1"
    rule_no         = 301
    action          = "allow"
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
    from_port       = 0
    to_port         = 0
  }

  tags = merge({ "Name" = "${var.base_name}-nacl3" }, var.common_tags)
}

resource "aws_network_acl_association" "subnet0" {
  network_acl_id = aws_network_acl.nacl0.id
  subnet_id      = aws_subnet.subnet0.id
}
resource "aws_network_acl_association" "subnet1" {
  network_acl_id = aws_network_acl.nacl1.id
  subnet_id      = aws_subnet.subnet1.id
}
resource "aws_network_acl_association" "subnet2" {
  network_acl_id = aws_network_acl.nacl2.id
  subnet_id      = aws_subnet.subnet2.id
}
resource "aws_network_acl_association" "subnet3" {
  network_acl_id = aws_network_acl.nacl3.id
  subnet_id      = aws_subnet.subnet3.id
}
