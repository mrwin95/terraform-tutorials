module "cloudfront" {
  source              = "../certificate/modules/cloudfront"
  account_id          = ""
  acm_certificate_arn = ""
  logging_prefix      = ""
  logging_bucket      = ""
  price_class         = ""
  comment             = ""
  enabled             = true
}
# module "route53" {
#   source      = "../devops-tutorials/modules/route53"
#   domain_name = var.domain_name
# }

# module "acm_dns_validation_cache" {
#   #   providers = {
#   #     "region" = "${var.region}"
#   #   }
#   source      = "../certificate/modules/acm_dns_validation"
#   region      = var.region
#   domain_name = module.route53.domain_name
# }


# provider "local" {}

# resource "null_resource" "update_nameservers" {
#   provisioner "local-exec" {
#     command = <<EOT
#          curl -X PUT "https://api.godaddy.com/v1/domains/${module.route53.domain_name}/nameservers" \
#       -H "Authorization: sso-key ${var.goddady_key}:${var.goddady_secret}" \
#       -H "Content-Type: application/json" \
#       -d '{
#         "nameservers": [
#             "${module.route53.nameservers[0]}",
#             "${module.route53.nameservers[1]}",
#             "${module.route53.nameservers[2]}",
#             "${module.route53.nameservers[3]}"
#         ]
#       }'
#     EOT
#   }
# }

# module "certificate" {
#   source            = "../certificate/modules/acm"
#   domain_name       = module.route53.domain_name
#   alternative_names = module.route53.domain_name
# }
