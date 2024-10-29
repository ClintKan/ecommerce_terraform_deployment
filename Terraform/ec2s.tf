# Creating of the EC2 Instance for the web server in AZ - us-east-1a, in the pub subnet
resource "aws_instance" "WebSrv-1a" {
  ami           = "ami-0866a3c8686eaeeba" # AMI ID of Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type = var.instance_type       # Specify the desired EC2 instance size.

  # Security groups control the inbound and outbound traffic to WebSrv EC2 instance.
  vpc_security_group_ids = [aws_security_group.pub_secgrp.id] #
  key_name               = "ck_wkld5"                         # The key pair name for the workload
  user_data              = file("../Scripts/Frontend.sh")
  subnet_id              = aws_subnet.pub_subnet_1a.id # associating a subnet to be tied to this EC2

  tags = {
    "Name" : "WebSrv-1a"
  }

  depends_on = [aws_instance.AppSrv-1a]

}

# Creating of the EC2 Instance for the web server in AZ - us-east-1b, in the pub subnet
resource "aws_instance" "WebSrv-1b" {
  ami           = "ami-0866a3c8686eaeeba" # AMI ID of Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type = var.instance_type       # Specify the desired EC2 instance size.

  # Security groups control the inbound and outbound traffic to WebSrv EC2 instance.
  vpc_security_group_ids = [aws_security_group.pub_secgrp.id] #
  key_name               = "ck_wkld5"                         # The key pair name for the workload
  user_data              = file("../Scripts/Frontend.sh")
  subnet_id              = aws_subnet.pub_subnet_1b.id # associating a subnet to be tied to this EC2

  tags = {
    "Name" : "WebSrv-1b"
  }

  depends_on = [aws_instance.AppSrv-1b]

}

#######################------------------------------------------------------------------------------------------------------------


# Creating of the EC2 Instance for the App server in AZ - us-east-1a, in the priv subnet
resource "aws_instance" "AppSrv-1a" {
  ami           = "ami-0866a3c8686eaeeba" # AMI ID of Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type = var.instance_type       # Specify the desired EC2 instance size.

  # Security groups control the inbound and outbound traffic to WebSrv EC2 instance.
  vpc_security_group_ids = [aws_security_group.priv_secgrp.id] #
  key_name               = "ck_wkld5"                          # The key pair name for the workload
  user_data              = file("../Scripts/Backend.sh")
  subnet_id              = aws_subnet.priv_subnet_1a.id # associating a subnet to be tied to this EC2

  tags = {
    "Name" : "AppSrv-1a"
  }

  depends_on = [aws_db_instance.postgres_db]

}

# Creating of the EC2 Instance for the App server in AZ - us-east-1b, in the priv subnet
resource "aws_instance" "AppSrv-1b" {
  ami           = "ami-0866a3c8686eaeeba" # AMI ID of Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type = var.instance_type       # Specify the desired EC2 instance size.

  # Security groups control the inbound and outbound traffic to WebSrv EC2 instance.
  vpc_security_group_ids = [aws_security_group.priv_secgrp.id] #
  key_name               = "ck_wkld5"                          # The key pair name for the workload
  user_data              = file("../Scripts/Backend.sh")
  subnet_id              = aws_subnet.priv_subnet_1b.id # associating a subnet to be tied to this EC2

  tags = {
    "Name" : "AppSrv-1b"
  }

  depends_on = [aws_db_instance.postgres_db]

}

#######################------------------------------------------------------------------------------------------------------------


