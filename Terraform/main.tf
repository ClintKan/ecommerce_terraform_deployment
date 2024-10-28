#Creating of a VPC
resource "aws_vpc" "wl5vpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {

    "Name" : "wl5vpc"
  }
}

#Creating the elastic IP
resource "aws_eip" "elastic_ip_1b" {
  #instance = aws_nat_gateway.wl5vpc_ngw_1b.id
  domain = "vpc"
  tags = {
    "Name" : "wl5vpc_eip_1b"
  }
}

#Creating the elastic IP
resource "aws_eip" "elastic_ip_1a" {
  #instance = aws_nat_gateway.wl5vpc_ngw_1a.id
  domain = "vpc"
  tags = {
    "Name" : "wl5vpc_eip_1a"
  }
}

resource "aws_vpc_peering_connection" "Peering_wl5_default" {
  # peer_owner_id = var.peer_owner_id
  peer_vpc_id = aws_vpc.wl5vpc.id       #ID of the target VPC
  vpc_id      = "vpc-078d543d16826cfcd" #ID of the VPC requesting
  auto_accept = true

  accepter { # using this block because vpc wl5vpc is the one accepting
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering between wl5vpc and Default"
  }
}
