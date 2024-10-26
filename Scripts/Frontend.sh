#!/bin/bash
sudo apt update && sudo apt upgrade -y

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt update && sudo apt upgrade -y
sudo apt --fix-broken install
sudo apt install nodejs npm

cd C5-Deployment-Workload-5/frontend/

npm install react-scripts --save

# screen

export NODE_OPTIONS=--openssl-legacy-provider
npm start
