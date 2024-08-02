resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id   = "s3-origin"
    origin_path = ""

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.id
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = var.comment
  default_root_object = ""
  default_cache_behavior {

    target_origin_id = "s3-origin"

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    cached_methods         = [""]
    allowed_methods = [{
      items          = ["GET", "HEAD"]
      cached_methods = ["GET", "HEAD"]
    }]

    function_association {
      event_type   = "viewer-request"
      function_arn = "${aws_lambda_function.CloudFrontDefaultIndexForOrigin.arn}:${aws_lambda_function.CloudFrontDefaultIndexForOrigin.version}"
    }
    function_association {
      event_type   = "origin-request"
      function_arn = "${aws_lambda_function.CloudFrontDefaultIndexForOrigin.arn}:${aws_lambda_function.CloudFrontDefaultIndexForOrigin.version}"
    }

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = "${aws_lambda_function.CloudFrontDefaultIndexForOrigin.arn}:${aws_lambda_function.CloudFrontDefaultIndexForOrigin.version}"
    }
  }

  price_class = var.price_class
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  logging_config {
    bucket          = var.logging_bucket
    include_cookies = false
    prefix          = var.logging_prefix
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"

  }
}

resource "aws_cloudfront_origin_access_identity" "cloudfront_origin_access_identity" {
  comment = ""
}

resource "aws_s3_bucket" "origin" {
  bucket_prefix = "cloudfront-origin-"
}

resource "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
  name = "CachingOptimized2"
  parameters_in_cache_key_and_forwarded_to_origin {
    query_strings_config {
      query_string_behavior = ""
    }
    cookies_config {
      cookie_behavior = ""
    }
    headers_config {

    }
  }
}


resource "aws_lambda_function" "CloudFrontDefaultIndexForOrigin" {
  # Configuration will be populated after import
  # arn:aws:lambda:us-east-1:792248914698:function:CloudFrontDefaultIndexForOrigin
  arn           = "arn:aws:lambda:us-east-1:792248914698:function:CloudFrontDefaultIndexForOrigin"
  function_name = "CloudFrontDefaultIndexForOrigin"
  handler       = "index.handler"
  id            = "CloudFrontDefaultIndexForOrigin"
  #   invoke_arn                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:792248914698:function:CloudFrontDefaultIndexForOrigin/invocations"
  #   last_modified                  = "2024-08-01T14:34:35.000+0000"
  #   layers                         = []
  #   memory_size                    = 256
  package_type = "Zip"
  #   qualified_arn                  = "arn:aws:lambda:us-east-1:792248914698:function:CloudFrontDefaultIndexForOrigin:132"
  #   qualified_invoke_arn           = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:792248914698:function:CloudFrontDefaultIndexForOrigin:132/invocations"
  #   reserved_concurrent_executions = -1
  role             = "arn:aws:iam::792248914698:role/service-role/CloudFrontDefaultIndexForOrigin-role-8wmftjrc"
  runtime          = "nodejs16.x"
  skip_destroy     = false
  source_code_size = 3422
  #   tags             = {}
  #   tags_all         = {}
  timeout = 30
  #   version = "132"

  #   ephemeral_storage {
  #     size = 512
  #   }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/CloudFrontDefaultIndexForOrigin"
  }

  #   tracing_config {
  #     mode = "PassThrough"
  #   }

}

