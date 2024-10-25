resource "aws_security_group" "members-sg" {
  vpc_id      = var.vpc_id
  name        = "members-mum-sg"
  description = "members-mum-sg"

  tags = {
    Name = "members-num-sg"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_blocks]
  }

  ingress {
    from_port   = 88
    to_port     = 88
    protocol    = "tcp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 88
    to_port     = 88
    protocol    = "udp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
  }

  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
    description = "WinRM"
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 49152
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 49152
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "udp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "udp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = [var.private_zone1_010, var.private_zone2_1610]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "controller-sg" {
  vpc_id      = var.vpc_id
  name        = "controller-mum-sg"
  description = "controller-mum-sg"
  tags = {
    Name = "controller-mum-sg"
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
  }

  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
    description = "WinRM"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [ingress, egress]
  }
}

resource "aws_security_group" "sql-sg" {
  vpc_id      = var.vpc_id
  name        = "sql-mum-sg"
  description = "sql-mum-sg"

  tags = {
    Name = "sql-num-sg"
  }

  ingress {
    from_port   = 9182
    to_port     = 9182
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [ingress, egress]
  }

}
