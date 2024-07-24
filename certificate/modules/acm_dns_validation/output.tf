output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate ARN"
  value       = aws_acm_certificate.compo_acm.arn
}
