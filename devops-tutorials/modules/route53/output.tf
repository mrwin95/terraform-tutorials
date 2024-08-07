output "nameservers" {
  value = aws_route53_zone.domain_name.name_servers
}

output "domain_name" {
  value = aws_route53_zone.domain_name.name
}
