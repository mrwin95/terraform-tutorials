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
  tag_value               = var.tag_value
  role_name               = module.iam_role.iam_role_name
  ec2_role_name           = module.iam_role.iam_role_name
}

module "iam_role" {
  source             = "../modules/roles"
  iam_role_name      = var.iam_role_name
  assume_role_policy = var.iam_role_policy_attachment
}
