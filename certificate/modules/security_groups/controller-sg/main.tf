resource "aws_security_group" "controller-sg" {
  vpc_id      = var.vpc_id
  name        = "controller-mum-sg"
  description = "controller-mum-sg"

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
}



data "aws_security_group" "controller" {
  filter {
    name   = "group-name"
    values = ["controller-mum-sg"]
  }
}

resource "aws_security_group_rule" "ingress_all" {

  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id        = data.aws_security_group.controller.id
  source_security_group_id = data.aws_security_group.controller.id
}

resource "aws_security_group_rule" "ingress" {

  for_each  = { for idx, rule in var.rules : "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule }
  type      = "ingress"
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id        = data.aws_security_group.controller.id
  source_security_group_id = var.member_sec_id
}

