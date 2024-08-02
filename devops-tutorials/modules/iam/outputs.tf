output "iam_new_user" {
  value = aws_iam_user.iam_user.arn
}

output "iam_new_user_access_id" {
  value = aws_iam_access_key.iam_access_key.id
}

output "iam_new_user_access_key" {
  value     = aws_iam_access_key.iam_access_key.secret
  sensitive = true
}
