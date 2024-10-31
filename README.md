# Ecommerce Terraform Deployment

## Purpose
The purpose of this workload is to automate the deployment of an ecommerce application using Terraform and Jenkins, implementing Infrastructure as Code (IaC). This allows for more consistent, repeatable, and manageable infrastructure setups, significantly improving upon the manual processes used in previous workloads.


<div align="center">
	<img width="630" alt="image" src="https://github.com/user-attachments/assets/123fecb7-21a3-41b1-a74d-a5d6c93ab550">
</div>


## Steps Taken

1. **Manual Deployment for Understanding**:
   - Initially deployed the application manually on two EC2 instances (frontend and backend) to understand the setup process. This step was crucial as it provided insights into the necessary configurations and potential challenges before automating them.

2. **Infrastructure Creation using Terraform (IaC)**:
   - Created multiple '.tf' files that defined all necessary resources for the application:
     - **VPC and Subnets**: Created a custom VPC (`wl5vpc`) and configured public and private subnets across two availability zones.
     - **EC2 Instances**: Deployed two EC2 instances for the frontend and two for the backend, ensuring proper security, redundancy/availability.
     - **Load Balancer**: Configured a load balancer to route traffic effectively between the frontend EC2s.
     - **RDS Database**: Added an RDS instance to store application data, enhancing data management and availability.

   - **Terraform Files Created**:
     - `ec2s.tf`: *This had all four EC2s creation code*
     - `main.tf`: *This had the custom VPC, VPC Peering between the two VPCs default and custom, load balancer. Then it also had Elastic IPs, (in both
       availability zones).*
     - `network.tf`: *This had the internet gateway, the two NAT gateways attached in the public subnets of both availability zones. Then, the
	public & private route tables (and their associations), the security groups; public, private and the RDS'*
     - `outputs.tf`: *This was to written to output the IP addresses of both frontend EC2s*
     - `providers.tf`: *This had the aws variable identifiers (for the key to be used for authenticating. The epecific details of these credentials 
	were passed in Jenkins though. More on that later.*
     - `rds.tf`: *This was the file showing housing how the RDS was to be created - with which infrastructure specifics.*
     - `security.tf`: *This was the file with the security groups controlling the ingress and egress traffic for all 4 EC2s and the RDS instance.*
     - `variables.auto.tf`: *This declared the region in which the infrastructure was to be placed in and the type of EC2s.*
     - `variables.tf`: *.This declared the variables that surface anywhere within the above .tf files, plus the credentials passed from Jenkins.*

3. **Jenkins CI/CD Pipeline**:
   - Integrated Jenkins to automate the deployment pipeline. The stages include:
     - **Build**: Prepared the Jenkins' environment for the deployment of the application code onto the Jenkins EC2.
     - **Test**: This was running pre-defined tests to ensure code quality.
     - **Init, Plan, and Apply**: These were all Terraform extrapolated commands incorporated into the Jenkins' CI/CD pipeline. They ensured the infrastructure was built according to the defined specifications of the Terraform ".tf" files.

4. **Scripting for Automation**:
   - Created user data scripts (located in the Scripts folder) to automate the manual steps that were done in Step 1 to configure and prepare the
     frontend and backend EC2 instances during their creation. This automation streamlines the deployment process by automatically installing
     dependencies and configuring environment settings.

5. **Environment Variable Management**:
   - Used Jenkins Secret Manager to handle sensitive information, such as AWS credentials, ensuring security and compliance.

6. **Monitoring Setup**:
   - Deployed an additional EC2 instance in the default VPC for monitoring purposes to track the health and performance of the deployed resources in the custom VPC named _**wl5vpc**_.

7. **Documentation**:
   - Created a comprehensive README file documenting the process, challenges faced, and potential optimizations for future iterations.


## Issues/Troubleshooting
- **Instance Configuration Issues**: Initially faced challenges with incorrect security group settings that prevented communication between the frontend and backend EC2s. This was resolved by correctly configuring the security groups to allow necessary traffic.
- **Database Connection Errors**: Encountered issues connecting to the RDS database due to incorrect environment variable settings. This was rectified by ensuring that the settings in `settings.py` were appropriately configured.


## Optimization
- Future improvements could include:
  - Considering the use of containerization (e.g., Docker) for the application deployment to simplify the management of app and
    environment dependency management.
  - Automating the database migrations further within the CI/CD pipeline for smoother updates and changes.
  - Creating two RDS Databases instead of one. This would bring about redundancy on all tiers not just the first two layers.
  - Setting up HTTPS - using SSL/TSL certs — for a more secure connection
  - Use Route53 to set up a custom DNS name - i.e. ecommerce.com
  - Using Modules to make the terraform code re-usable.
  - Creating of an S3 bucket to better manage/handle the terraform state file. Having a centralized
  - Automating the updating of different components of the application code to reflect the backend IP address of the backend EC2s.


## Business Intelligence
- Questions to consider:
  - How can the deployment pipeline be enhanced to reduce downtime during updates?
  - What additional metrics can be collected to improve user experience?
  - How can we ensure data security and compliance in our deployment?

## Conclusion
This workload showcases the power of Terraform and Jenkins in automating the deployment process, to provide a robust, scalable and yet more resiient infrastructure for an application. This can be an efficient and more consistent, yet streamlined way of setting up cloud infrastructure in any environment, paving the way for more efficient development practices.
