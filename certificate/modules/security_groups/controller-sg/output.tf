output "controller-sg-id" {
  value = aws_security_group.controller-sg.id
}

output "ingress_rules" {
  value = [for rule in aws_security_group_rule.ingress : rule.id]
}
