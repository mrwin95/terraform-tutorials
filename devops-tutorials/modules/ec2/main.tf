resource "aws_instance" "ec2_instance" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  user_data              = templatefile("${path.module}/install_template/install.sh", {})
  tags = {
    "Name" = "Jenkins and SonarQube"
  }

  root_block_device {
    volume_size = var.ec2_volume_size
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = var.vpc_security_group_name
  description = "Securiry group name"
  ingress = [
    for port in var.security_ports : {
      description      = "inbound"
      from_port        = port
      to_port          = port
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Jenkins Security Group"
  }
}
