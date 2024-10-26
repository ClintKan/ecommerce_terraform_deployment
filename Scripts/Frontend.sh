#!/bin/bash

#Checking and installing updates
sudo apt update && sudo apt upgrade -y

#Installing Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

#Checking and installing updates
sudo apt update && sudo apt upgrade -y

#Fixing any broken dependencies of pkg mgmt systems
sudo apt --fix-broken install
sudo apt install nodejs npm

#Cloning the source files of the app on to the EC2
cd C5-Deployment-Workload-5/frontend/

#Installing react-scripts pkgs
npm install react-scripts --save

# screen

#Setting Node.js options for legacy compatibility and starting the app
export NODE_OPTIONS=--openssl-legacy-provider
npm start
