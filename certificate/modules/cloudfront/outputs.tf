output "distribution_id" {
  value = aws_cloudfront_distribution.cloudfront_distribution.id
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.origin.bucket
}
