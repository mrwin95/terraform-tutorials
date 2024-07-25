resource "aws_security_group" "security_group" {
  name   = var.security_group_name
  vpc_id = var.vpc_id

  ingress = [
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = -1
      self        = false
      description = ""
    }
  ]

  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
