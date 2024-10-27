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
resource "aws_eip" "elastic_ip" {
  #instance = aws_instance.nat_gateway.id          # optional
  domain = "vpc"
  tags = {
    "Name" : "wl5vpc_eip"
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
