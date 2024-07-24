locals {
  name = ""
}

resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  aliases             = [local.name]
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  wait_for_deployment = true
  default_cache_behavior {
    allowed_methods        = ["GET"]
    cached_methods         = []
    target_origin_id       = ""
    cache_policy_id        = ""
    viewer_protocol_policy = ""
  }

  origin {
    domain_name              = ""
    origin_id                = ""
    origin_access_control_id = ""
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = ""
  }
}

# resource "aws_cloudfront_origin_access_control" "name" {
#     origin_access_control_origin_type = ""

# }
