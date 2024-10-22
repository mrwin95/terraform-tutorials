region                 = "ap-south-1"
project_name           = "mumbai_prod"
vpc_cidr               = "10.20.0.0/16"
public_subnet_az1_cidr = "10.20.144.0/20"
public_subnet_az2_cidr = "10.20.160.0/20"

private_app_subnet_az1_cidr = "10.20.0.0/19"
private_app_subnet_az2_cidr = "10.20.32.0/19"
# private_data_subnet_az1_cidr = "10.20.64.0/19"
# private_data_subnet_az2_cidr = "10.20.96.0/19"

domain_name       = "a838.vip"
alternative_names = "*.a838.vip"
