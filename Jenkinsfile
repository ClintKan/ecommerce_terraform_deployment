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
        echo "$PrivateIP"
        python3.9 -m venv venv
        '''
     }
   }
    stage ('Test') {
      steps {
        sh '''#!/bin/bash
        source venv/bin/activate
        pip install -r ./backend/requirements.txt
        pip install pytest-django
        python backend/manage.py makemigrations
        ''' 
      }
    }
   
     stage('Init') {
       steps {
          dir('Terraform') {
            sh '''
            sudo apt update && sudo apt install -y gnupg software-properties-common
            wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt upgrade -y
            sudo apt-get install terraform
            terraform --version
            terraform init
            ''' 
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
