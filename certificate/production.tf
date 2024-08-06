module "acm_dns_validation" {
  source      = "./modules/acm_dns_validation"
  region      = var.region
  domain_name = var.domain_name
}

# module "cloudfront" {
#   source              = "./modules/cloudfront"
#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "cloudfront"
#   price_class         = var.price_class
#   logging_bucket      = ""
#   logging_prefix      = ""
#   acm_certificate_arn = module.acm_dns_validation.acm_certificate_arn
# }
