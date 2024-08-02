module "iam" {
  source   = "../modules/iam"
  iam_user = var.user_name
}

module "ec2" {
  source                  = "../modules/ec2"
  ec2_ami                 = var.ec2_ami
  ec2_instance_type       = var.ec2_instance_type
  ec2_volume_size         = var.ec2_volume_size
  key_name                = var.key_name
  vpc_security_group_name = var.vpc_security_group_name
  security_ports          = var.security_ports
}
