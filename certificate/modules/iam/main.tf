resource "aws_iam_user" "iam_user" {
  name = "${var.project_name}-iamuser"
}

resource "aws_iam_access_key" "iam_access_key" {
  user = aws_iam_user.iam_user.name
}

// inline policy

data "aws_iam_policy_document" "s3_get_put_delete_document" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = []
  }
}

resource "aws_iam_policy" "s3_get_put_delete_policy" {
  name   = ""
  policy = data.aws_iam_policy_document.s3_get_put_delete_document.json
}
