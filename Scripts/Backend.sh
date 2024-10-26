#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update && sudo apt upgrade -y

sudo apt install python3.9 python3-pip python3.9-venv python3.9-dev -y

sudo apt install python3-pip -y && pip install --upgrade pip

python3.9 -m venv venv
source venv/bin/activate

git clone https://github.com/kura-labs-org/C5-Deployment-Workload-5.git

pip install -r ./C5-Deployment-Workload-5/backend/requirements.txt

# local variable to call the private IP of the ec2 i.e in list format 'IP_Address'

chmod +x C5-Deployment-Workload-5/backend/manage.py

python C5-Deployment-Workload-5/backend/manage.py runserver 0.0.0.0:8000
