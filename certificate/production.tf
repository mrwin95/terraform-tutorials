module "acm_dns_validation_cache" {
  #   providers = {
  #     "region" = "${var.region}"
  #   }
  source = "./modules/acm_dns_validation"
  region = var.region
  #   region_cache = var.region_cache
  #   region_site  = var.region_site
  domain_name = var.domain_name
}

# module "acm_dns_validation_site" {
#   #   providers = {
#   #     "region" = "${var.region}"
#   #   }
#   source = "./modules/acm_dns_validation"
#   region = var.region_site
#   #   region_cache = var.region_cache
#   #   region_site  = var.region_site
#   domain_name = var.domain_name
# }

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
