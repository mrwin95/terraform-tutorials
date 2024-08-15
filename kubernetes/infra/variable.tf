variable "ami" {

}

variable "key_name" {
  type = string
}

variable "security_groups_master" {
  type = set(string)
}

variable "security_groups_worker" {
  type = set(string)
}

variable "subnet_id" {
}

variable "volume_size" {
  type = number
}
