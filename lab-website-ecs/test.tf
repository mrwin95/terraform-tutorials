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

  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

module "nat_gateway" {
  source                     = "../certificate/modules/nat-gateway"
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  aws_internet_gateway       = module.vpc.aws_internet_gateway
}

module "security_groups" {
  source = "../certificate/modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ecs_tasks_execution_role" {
  source       = "../certificate/modules/ecs-task-execution-role"
  project_name = module.vpc.project_name
}

module "acm_certificate" {
  source            = "../certificate/modules/acm"
  alternative_names = var.alternative_names
  domain_name       = var.domain_name
}
