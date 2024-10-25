
data "aws_security_group" "controller" {
  filter {
    name   = "group-name"
    values = ["controller-mum-sg"]
  }
}

data "aws_security_group" "sql" {
  filter {
    name   = "group-name"
    values = ["sql-mum-sg"]
  }
}

resource "aws_security_group_rule" "ingress_3389" {

  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id        = data.aws_security_group.sql.id
  source_security_group_id = data.aws_security_group.controller.id
}

resource "aws_security_group_rule" "ingress" {

  for_each  = { for idx, rule in var.rules : "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule }
  type      = "ingress"
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id        = data.aws_security_group.sql.id
  source_security_group_id = data.aws_security_group.sql.id
  lifecycle {
    ignore_changes = [type, from_port, to_port, protocol, security_group_id, source_security_group_id]
  }
}

