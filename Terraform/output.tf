# # Displaying the public IP address of the WebSrv EC2 in AZ-1a instance after creation.
# output "instance_ip" {
#   value = aws_instance.WebSrv-1a.public_ip
# }

# # Displaying the public IP address of the WebSrv EC2 in AZ-1b instance after creation.
# output "instance_ip" {
#   value = aws_instance.WebSrv-1b.public_ip

# }

# # Output the public IP address of the NAT Gateway's Elastic IP
# output "nat_gateway_ip" {
#   value = aws_nat_gateway.test_ngw.public_ip

# }

# output "rds_endpoint" {
#   value = aws_db_instance.postgres_db.endpoint
# }