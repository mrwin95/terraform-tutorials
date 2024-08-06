output "arm_role" {
  value = aws_iam_role.iam_role_name.arn
}

output "iam_role_name" {
  value = aws_iam_role.iam_role_name.name
}
