#Creating of a VPC
resource "aws_vpc" "wl5vpc" {
  cidr_block = "10.0.0.0/24"
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
