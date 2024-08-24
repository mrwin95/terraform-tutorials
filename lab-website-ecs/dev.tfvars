region                 = "ap-south-1"
project_name           = "mumbai_dev"
vpc_cidr               = "10.20.0.0/16"
public_subnet_az1_cidr = "10.20.0.0/24"
public_subnet_az2_cidr = "10.20.1.0/24"

private_app_subnet_az1_cidr  = "10.20.2.0/24"
private_app_subnet_az2_cidr  = "10.20.3.0/24"
private_data_subnet_az1_cidr = "10.20.4.0/24"
private_data_subnet_az2_cidr = "10.20.5.0/24"

domain_name       = "a838.vip"
alternative_names = "*.a838.vip"
