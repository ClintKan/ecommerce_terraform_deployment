#!/bin/bash

#Checking and installing updates
sudo apt update && sudo apt upgrade -y


####--------Installing Node Exporter

# Downloading and installing Node Exporter
NODE_EXPORTER_VERSION="1.5.0"
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar xvfz node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64*

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

# Add Node Exporter job to Prometheus config
cat << EOF | sudo tee -a /opt/prometheus/prometheus.yml

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
EOF

# Restart Prometheus to apply the new configuration
sudo systemctl restart prometheus

echo "Node Exporter job added to Prometheus configuration. Prometheus has been restarted."


####--------- Installing App requirements


#Installing pre-req repos prior to installing bins & lins on line #16
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update && sudo apt upgrade -y

#To extract the private IP address that will be used by the settings.py in ./backend/my_project/
export PrivateIP="$(hostname -I)"

#Cloning the source files of the app on to the EC2
git clone https://github.com/kura-labs-org/C5-Deployment-Workload-5.git

#Copying the cloned folder into the proper project folder name
cp -r C5-Deployment-Workload-5 ecommerce_terraform_deployment

# Deleting the cloned (old) folder
rm -rf C5-Deployment-Workload-5/

cd ./ecommerce_terraform_deployment

#creating and activating a virtual environment 'venv'
python3.9 -m venv venv
source venv/bin/activate

# Chnaging into the proper folder
cd ./ecommerce_terraform_deployment/backend/

#Installing libs needed for the app
sudo apt install python3.9 python3-pip python3.9-venv python3.9-dev -y
sudo apt install python3-pip -y && pip install --upgrade pip

#Installing more requirement libs/bins for the app
pip install -r requirements.txt

# local variable to call the private IP of the ec2 i.e in list format 'IP_Address'

#Changing permissions of the file 'manage.py' to be run
chmod +x ./manage.py

#Running the Django Server
python ./manage.py runserver 0.0.0.0:8000
