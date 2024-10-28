pipeline {
  agent any
   stages {
    stage ('Build') {
      steps {
        sh '''#!/bin/bash
        sudo apt update
        sudo apt upgrade -y
        sudo add-apt-repository ppa:deadsnakes/ppa -y
        sudo apt install python3.9 python3-pip python3.9-venv -y python3.9-dev -y
        echo "Line 11"
        echo "$PrivateIP"
        echo "Line 13"
        pip install -r requirements.txt
        python3.9 -m venv venv
        . venv/bin/activate
        '''
     }
   }
    stage ('Test') {
      steps {
        sh '''#!/bin/bash
        pip install pytest-django
        python backend/manage.py makemigrations
        python backend/manage.py migrate
        pytest backend/account/tests.py --verbose --junit-xml test-reports/results.xml
        ''' 
      }
    }
   
     stage('Init') {
       steps {
          dir('Terraform') {
            sh 'terraform init' 
            }
        }
      } 
     
      stage('Plan') {
        steps {
          withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'), 
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key'),
                        string(credentialsId: 'DB_Username', variable: 'db_username'),
                        string(credentialsId: 'DB_Password', variable: 'db_password')]) {
                            dir('Terraform') {
                              sh 'terraform plan -out plan.tfplan -var="db_username=${db_username}" -var="db_password=${db_password} -var="aws_access_key=${aws_access_key}" -var="aws_secret_key=${aws_secret_key}"' 
                            }
          }
        }     
      }
      stage('Apply') {
        steps {
          dir('Terraform') {
            sh 'terraform apply plan.tfplan'
            }
        }  
      }       
    }
  }
