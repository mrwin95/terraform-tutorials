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
    from_port       = 80
    to_port         = 80
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = "tcp"
    self            = false
    security_groups = [aws_security_group.alb_security_group.id]
    description     = "http access"
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

