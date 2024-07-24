resource "aws_wafv2_web_acl" "common_waf2" {
  name  = var.waf_name
  scope = "REGIONAL"
  default_action {
    allow {

    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = var.waf_metric_name
    sampled_requests_enabled   = false
  }
}

// associate to alb

resource "aws_wafv2_web_acl_association" "waf_associate_alb" {
  resource_arn = var.aws_lb
  web_acl_arn  = aws_wafv2_web_acl.common_waf2.arn
}
