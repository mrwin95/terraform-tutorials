provider "aws" {
  region = var.region_a
  alias  = "mumbai"
}

provider "aws" {
  region = var.region_b
  alias  = "hongkong"
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  provider      = aws.mumbai
  vpc_id        = var.vpc_a_id
  peer_vpc_id   = var.vpc_b_id
  peer_owner_id = var.account_b_id
  peer_region   = var.region_b # region of peer vpc

  tags = {
    Name = "mumbai-to-hongkong-peering"
  }
}


resource "aws_vpc_peering_connection_accepter" "vpc_peering_accept" {
  provider                  = aws.hongkong
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true
  depends_on                = [aws_vpc_peering_connection.vpc_peering]
  tags = {
    Name = "hongkong-to-mumbai-peering"
  }
}

