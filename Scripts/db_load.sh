#!/bin/bash

# Create the tables in RDS
python manage.py makemigrations account
python manage.py makemigrations payments
python manage.py makemigrations product
python manage.py migrate

# Dump data from SQLite to JSON
python manage.py dumpdata --database=sqlite --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json

# Load the JSON data into RDS
python manage.py loaddata datadump.json
