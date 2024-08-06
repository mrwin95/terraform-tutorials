resource "aws_iam_role" "iam_role_name" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.iam_role_name.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
