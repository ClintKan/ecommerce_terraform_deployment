#!/bin/bash

# Create the tables in RDS
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py makemigrations account
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py makemigrations payments
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py makemigrations product
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py migrate

# Dump data from SQLite to JSON
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py dumpdata --database=sqlite --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json

# Load the JSON data into RDS
python /home/ubuntu/ecommerce_terraform_deployment/backend/manage.py loaddata datadump.json
