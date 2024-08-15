provider "aws" {
  profile = "sam"
  region  = "ap-south-1"
}

resource "aws_instance" "instance_master" {
  ami = var.ami
  root_block_device {
    volume_size = var.volume_size
  }

  instance_type = "t2.medium"
  user_data     = <<EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo hostnamectl set-hostname control-plane
    bash
  EOF

  key_name        = var.key_name
  security_groups = var.security_groups_master
  subnet_id       = var.subnet_id

  tags = {
    "Name" : "cka-master"
  }
}

resource "aws_instance" "instance_wk1" {
  ami = var.ami
  root_block_device {
    volume_size = var.volume_size
  }

  instance_type = "t2.medium"
  user_data     = <<EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo hostnamectl set-hostname worker1
    bash
  EOF

  key_name        = var.key_name
  security_groups = var.security_groups_worker
  subnet_id       = var.subnet_id

  tags = {
    "Name" : "cka-worker1"
  }
}

resource "aws_instance" "instance_wk2" {
  ami = var.ami
  root_block_device {
    volume_size = var.volume_size
  }

  instance_type = "t2.medium"
  user_data     = <<EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo hostnamectl set-hostname worker2
    bash
  EOF

  key_name        = var.key_name
  security_groups = var.security_groups_worker
  subnet_id       = var.subnet_id

  tags = {
    "Name" : "cka-worker2"
  }
}
