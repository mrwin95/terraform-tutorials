provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "CloudFrontDefaultIndexForOrigin" {
  arn              = var.arn
  function_name    = "CloudFrontDefaultIndexForOrigin"
  handler          = "index.handler"
  id               = "CloudFrontDefaultIndexForOrigin"
  package_type     = "Zip"
  role             = var.arn_role
  runtime          = "nodejs16.x"
  skip_destroy     = false
  source_code_size = 3422

  timeout = 30

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/CloudFrontDefaultIndexForOrigin"
  }
}
