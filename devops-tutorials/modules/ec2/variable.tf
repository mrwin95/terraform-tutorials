variable "ec2_ami" {}
variable "ec2_instance_type" {}
variable "key_name" {}
variable "ec2_volume_size" {}
variable "vpc_security_group_name" {}
variable "security_ports" {
  type = set(number)
}
