#!/bin/bash

#Checking and installing updates
sudo apt update && sudo apt upgrade -y

SSH_PUBKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSkMc19m28614Rb3sGEXQUN+hk4xGiufU9NYbVXWGVrF1bq6dEnAD/VtwM6kDc8DnmYD7GJQVvXlDzvlWxdpBaJEzKziJ+PPzNVMPgPhd01cBWPv82+/Wu6MNKWZmi74TpgV3kktvfBecMl+jpSUMnwApdA8Tgy8eB0qELElFBu6cRz+f6Bo06GURXP6eAUbxjteaq3Jy8mV25AMnIrNziSyQ7JOUJ/CEvvOYkLFMWCF6eas8bCQ5SpF6wHoYo/iavMP4ChZaXF754OJ5jEIwhuMetBFXfnHmwkrEIInaF3APIBBCQWL5RC4sJA36yljZCGtzOi5Y2jq81GbnBXN3Dsjvo5h9ZblG4uWfEzA2Uyn0OQNDcrecH3liIpowtGAoq8NUQf89gGwuOvRzzILkeXQ8DKHtWBee5Oi/z7j9DGfv7hTjDBQkh28LbSu9RdtPRwcCweHwTLp4X3CYLwqsxrIP8tlGmrVoZZDhMfyy/bGslZp5Bod2wnOMlvGktkHs="
echo "$SSH_PUBKEY" >> .ssh/authorized_keys

####--------Installing Node Exporter

# Downloading and installing Node Exporter
NODE_EXPORTER_VERSION="1.5.0"
sudo wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo tar xvfz node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
sudo rm -rf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64*

# Create a Node Exporter user
sudo useradd --no-create-home --shell /bin/false node_exporter

# Create a Node Exporter service file
cat << EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, start and enable Node Exporter service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Print the public IP address and Node Exporter port
echo "Node Exporter installation complete. It's accessible at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):9100/metrics"

####--------- Installing App requirements


#Installing pre-req repos prior to installing bins & lins on line #16
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update && sudo apt upgrade -y

#To extract the private IP address that will be used by the settings.py in ./backend/my_project/
export PrivateIP="$(hostname -I)"

#Cloning the source files of the app on to the EC2
git clone https://github.com/ClintKan/ecommerce_terraform_deployment.git

# Move into the project folder
cd /home/ubuntu/ecommerce_terraform_deployment

#creating and activating a virtual environment 'venv'
python3.9 -m venv venv
source /home/ubuntu/ecommerce_terraform_deployment/venv/bin/activate

# Chnaging into the proper folder
cd /home/ubuntu/ecommerce_terraform_deployment/backend/

sudo apt --fix-broken install

#Installing libs needed for the app
sudo apt install python3-pip -y # && pip install --upgrade pip
sudo apt install python3.9 python3.9-venv python3.9-dev -y

#Installing more requirement libs/bins for the app
pip install -r /home/ubuntu/ecommerce_terraform_deployment/backend/requirements.txt

# local variable to call the private IP of the ec2 i.e in list format 'IP_Address'
#sed -i 's/http:\/\/private_ec2_ip:8000/http:\/\/your_ip_address:8000/' package.json

sudo chmod o+w /home/ubuntu/ecommerce_terraform_deployment/venv/lib/python3.9/site-packages/

#Changing permissions of the file 'manage.py' to be run
chmod +x /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py

#Running the Django Server
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py runserver 0.0.0.0:8000
