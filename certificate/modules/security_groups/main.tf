// create  security group for ALB
resource "aws_security_group" "alb_security_group" {
  name        = "alb_security_grp"
  vpc_id      = var.vpc_id
  description = "enable http/https on port 80/443"

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = false
    description = "http access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = false
    description = "https access"
  }
  #   ingress = [
  #     { // http
  #       from_port   = 0
  #       to_port     = 0
  #       cidr_blocks = ["0.0.0.0/0"]
  #       protocol    = "tcp"
  #       self        = false
  #       description = "http access"
  #     },
  #     { // http
  #       from_port   = 443
  #       to_port     = 443
  #       cidr_blocks = ["0.0.0.0/0"]
  #       protocol    = "tcp"
  #       self        = false
  #       description = "https access"
  #     }
  #   ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #   egress = [
  #     {
  #       from_port   = 0
  #       to_port     = 0
  #       protocol    = "-1"
  #       cidr_blocks = ["0.0.0.0/0"]
  #     }
  #   ]

  tags = {
    "Name" = "Alb security group"
  }
}

resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_grp"
  vpc_id      = var.vpc_id
  description = "enable http/https on port 80/443"

  ingress {
    from_port       = 80
    to_port         = 80
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = "tcp"
    self            = false
    security_groups = [aws_security_group.alb_security_group.id]
    description     = "http access"
  }

  ingress {
    from_port       = 443
    to_port         = 443
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = "tcp"
    self            = false
    security_groups = [aws_security_group.alb_security_group.id]
    description     = "https access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "ECS security group"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_grp"
  vpc_id      = var.vpc_id
  description = "enable http/https on port 80/443"

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = false
    description = "http access"
  }

  ingress {
    from_port       = 22
    to_port         = 22
    cidr_blocks     = [var.ssh_ip_address]
    protocol        = "tcp"
    self            = false
    security_groups = [aws_security_group.alb_security_group.id]
    description     = "https access"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    cidr_blocks = ["12.0.0.0/16"]
    protocol    = "tcp"
    self        = false
    # security_groups = [aws_security_group.alb_security_group.id]
    description = "https access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "EC2 security group"
  }
}

resource "aws_security_group" "peering_conn" {
  name        = "peering_security_sgr"
  vpc_id      = var.vpc_id
  description = "enable peering connection"

  #   ingress = [
  #     {
  #       from_port   = 0
  #       to_port     = 0
  #       cidr_blocks = ["10.100.0.0/16"]
  #       protocol    = "-1"
  #       description = "Japan"
  #     },
  #     {
  #       from_port   = 0
  #       to_port     = 0
  #       cidr_blocks = ["10.10.0.0/16"]
  #       protocol    = "-1"
  #       description = "Hong Kong"
  #       }, {
  #       from_port   = 0
  #       to_port     = 0
  #       cidr_blocks = ["12.0.0.0/16"]
  #       protocol    = "-0"
  #       description = "Mumbai"
  #     },
  #   ]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "peering security group"
  }
}

resource "aws_security_group" "domain_member" {
  name        = "domain_member_security_sgr"
  vpc_id      = var.vpc_id
  description = "DomainMember-${module.workspace}"

  ingress = [
    {
      from_port   = 389
      to_port     = 389
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
      description = "LDAP"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
      }, {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    },
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp/udp"
    }
  ]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Domain Member security group ${module.workspace}"
  }
}


