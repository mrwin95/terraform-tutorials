// configure aws provider

provider "aws" {
  region  = var.region
  profile = "sam"
}

module "vpc" {
  source                 = "../certificate/modules/vpc"
  region                 = var.region
  project_name           = var.project_name
  vpc_cidr               = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr

  private_app_subnet_az1_cidr = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr
  #   private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  #   private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  dc_domain = var.dc_domain
  dc1_ip    = var.dc1_ip
  dc2_ip    = var.dc2_ip

}

module "nat_gateway" {
  source                    = "../certificate/modules/nat-gateway"
  public_subnet_az1_id      = module.vpc.public_subnet_az1_id
  public_subnet_az2_id      = module.vpc.public_subnet_az2_id
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
  #   private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  #   private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
  vpc_id               = module.vpc.vpc_id
  aws_internet_gateway = module.vpc.aws_internet_gateway

}

module "member-sg" {
  source             = "../certificate/modules/security_groups/member-sg"
  private_zone1_010  = var.private_zone1_010
  private_zone2_1610 = var.private_zone2_1610
  vpc_cidr_blocks    = module.vpc.vpc_cidr
  vpc_id             = module.vpc.vpc_id
}

module "controller-sg" {
  source          = "../certificate/modules/security_groups/controller-sg"
  vpc_id          = module.vpc.vpc_id
  vpc_cidr_blocks = module.vpc.vpc_cidr
  member_sec_id   = module.member-sg.member-sg-id
}




# resource "aws_security_group" "ec2_security_group" {
#   name        = "ec2_security_grp"
#   vpc_id      = module.vpc.vpc_id
#   description = "enable http/https on port 80/443"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     cidr_blocks = ["0.0.0.0/0"]
#     protocol    = "tcp"
#     self        = false
#     description = "http access"
#   }

#   ingress {
#     from_port   = 3389
#     to_port     = 3389
#     cidr_blocks = ["12.0.0.0/16"]
#     protocol    = "tcp"
#     self        = false
#     # security_groups = [aws_security_group.alb_security_group.id]
#     description = "https access"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     "Name" = "EC2 security group"
#   }
# }
# module "ecs_tasks_execution_role" {
#   source       = "../certificate/modules/ecs-task-execution-role"
#   project_name = module.vpc.project_name
# }

# module "acm_certificate" {
#   source            = "../certificate/modules/acm"
#   alternative_names = var.alternative_names
#   domain_name       = var.domain_name
# }

# module "alb" {
#   source                = "../certificate/modules/alb"
#   alb_security_group_id = module.security_groups.alb_security_group_id
#   certificate_arn       = module.acm_certificate.certificate_arn
#   public_subnet_az1_id  = module.vpc.public_subnet_az1_id
#   public_subnet_az2_id  = module.vpc.public_subnet_az2_id
#   vpc_id                = module.vpc.vpc_id
#   project_name          = "new-lab"
# }

# module "ec2" {
#   source = "../certificate/modules/jenkins"
#   vpc_id = module.vpc.vpc_id
#   subnet = module.vpc.public_subnet_az1_id
# }
