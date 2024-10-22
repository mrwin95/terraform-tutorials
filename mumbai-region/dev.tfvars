region                 = "ap-south-1"
project_name           = "mumbai_dev"
vpc_cidr               = "12.0.0.0/16"
public_subnet_az1_cidr = "12.0.128.0/20"
public_subnet_az2_cidr = "12.0.144.0/20"

private_app_subnet_az1_cidr = "12.0.0.0/20"
private_app_subnet_az2_cidr = "12.0.16.0/20"
# private_data_subnet_az1_cidr = "10.20.4.0/24"
# private_data_subnet_az2_cidr = "10.20.5.0/24"

domain_name       = "a838.vip"
alternative_names = "*.a838.vip"
dc1_ip            = "12.0.0.10"
dc2_ip            = "12.0.16.10"
dc_domain         = "kenzoo.net"

private_zone1_010  = "12.0.0.10/32"
private_zone2_1610 = "12.0.16.10/32"
