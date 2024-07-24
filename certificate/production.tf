module "acm_dns_validation" {
  source      = "./modules/acm_dns_validation"
  region      = var.region
  domain_name = var.domain_name
}
