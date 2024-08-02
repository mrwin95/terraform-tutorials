resource "aws_iam_user" "iam_user" {
  name = var.iam_user
}

resource "aws_iam_user_policy_attachment" "iam_policy_attachment" {
  user       = aws_iam_user.iam_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "iam_access_key" {
  user = aws_iam_user.iam_user.name
}
