#!/bin/bash

#Checking and installing updates
sudo apt update && sudo apt upgrade -y

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
