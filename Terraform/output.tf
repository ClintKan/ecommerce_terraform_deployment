# Displaying the public IP address of the WebSrv EC2 in AZ-1a instance after creation.
output "instance_ip_1a" {
  value = aws_instance.Frontend-1a.public_ip
}

# Displaying the public IP address of the WebSrv EC2 in AZ-1b instance after creation.
output "instance_ip_1b" {
  value = aws_instance.Frontend-1b.public_ip

}

# Output the public IP address of the NAT Gateway's Elastic IP
output "nat_gateway_ip" {
  value = aws_nat_gateway.wl5vpc_ngw_1a.id

}

# Output the public IP address of the NAT Gateway's Elastic IP in AZ 1b
output "nat_gateway_ip_1b" {
  value = aws_nat_gateway.wl5vpc_ngw_1b.id

}

output "rds_endpoint" {
  value = aws_db_instance.postgres_db.endpoint
}