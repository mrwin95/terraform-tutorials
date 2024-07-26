/**
    To create a VPC 
    1. create vpc
    2. create internet gateway
    3. create subnet (private and public)
*/

// create vpc

resource "aws_vpc" "vpc" {

  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    "Name" : "${var.project_name}-vpc"
  }
}

// create internet gw and attach to vpc


// get all avaiable zones in region

data "aws_availability_zones" "zones" {}

// create public subnet 01
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.zones.names[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public Subnet Az1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.zones.names[1]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public Subnet Az2"
  }
}

# resource "aws_subnet" "public_subnet_az3" {
#   vpc_id                          = aws_vpc.vpc.id
#   cidr_block                      = var.public_subnet_az3_cidr
#   availability_zone               = data.aws_availability_zones.zones.name[2]
#   map_customer_owned_ip_on_launch = true
#   tags = {
#     "Name" = "Public Subnet Az3"
#   }
# }

// create route table and add public routes

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  #   route = [
  #     {
  #       cidr_block = "0.0.0.0/0"
  #       gateway_id = aws_internet_gateway.igw.id
  #     }
  #   ]

  tags = {
    "Name" = "Public Route Table"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project_name}-igw"
  }
}
// associate public subnet az1 to public route table

resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_route_table_association" "public_subnet_az3_route_table_association" {
#   subnet_id      = aws_subnet.public_subnet_az3.id
#   route_table_id = aws_route_table.public_route_table.id
# }

// create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.zones.names[0]
  map_public_ip_on_launch = false
  tags = {
    "Name" = "Private App Subnet Az1"
  }
}

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.zones.names[1]
  map_public_ip_on_launch = false
  tags = {
    "Name" = "Private App Subnet Az2"
  }
}

// create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.zones.names[0]
  map_public_ip_on_launch = false
  tags = {
    "Name" = "Private Data Subnet Az1"
  }
}

resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.zones.names[1]
  map_public_ip_on_launch = false
  tags = {
    "Name" = "Private Data Subnet Az2"
  }
}

// create attachment to attach to vpc

# resource "aws_internet_gateway_attachment" "iga" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.vpc.id

# }
