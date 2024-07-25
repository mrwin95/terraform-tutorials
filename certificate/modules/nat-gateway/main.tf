resource "aws_eip" "eip_for_ng_az1" {
  tags = {
    "Name" = "nat gateway az1 eip"
  }
}

resource "aws_eip" "eip_for_ng_az2" {
  tags = {
    "Name" = "nat gateway az2 eip"
  }
}

// create nat gateway for public az

resource "aws_nat_gateway" "ng-az1" {
  allocation_id = aws_eip.eip_for_ng_az1.id
  subnet_id     = var.public_subnet_az1_id
  tags = {
    "Name" = "nat gateway az1"
  }
  depends_on = [var.aws_internet_gateway]
}

resource "aws_nat_gateway" "ng-az2" {
  allocation_id = aws_eip.eip_for_ng_az2.id
  subnet_id     = var.public_subnet_az2_id
  tags = {
    "Name" = "nat gateway az2"
  }
}

// create private route table and add route to 

resource "aws_route_table" "private_route_table_az1" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "Private Route Table Az1"
  }
}

resource "aws_route_table_association" "private_app_subnet_az1_association" {
  subnet_id      = var.private_app_subnet_az1_id
  route_table_id = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table_association" "private_data_subnet_az1_association" {
  subnet_id      = var.private_data_subnet_az1_id
  route_table_id = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table" "private_route_table_az2" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "Private Route Table Az2"
  }
}

resource "aws_route_table_association" "private_app_subnet_az2_association" {
  subnet_id      = var.private_app_subnet_az2_id
  route_table_id = aws_route_table.private_route_table_az2.id
}

resource "aws_route_table_association" "private_data_subnet_az2_association" {
  subnet_id      = var.private_data_subnet_az2_id
  route_table_id = aws_route_table.private_route_table_az2.id
}
