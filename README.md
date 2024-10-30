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
     - `ec2s.tf`: *[This had all four EC2s creation code]*
     - `main.tf`: *[This had the custom VPC, VPC Peering between the two VPCs default and custom, load balancer. Then it also had Elastic IPs, (in both
       availability zones),  ]*
     - `network.tf`: *[This had the internet gateway, the two NAT gateways attached in the public subnets of both availability zones. Then, the
       public & private route tables (and their associations), the security groups; public, private and the RDS' ]*
     - `outputs.tf`: *[This was to written to output the IP addresses of both frontend EC2s]*
     - `providers.tf`: *[This had the aws variable identifiers (for the key to be used for authenticating. The epecific details of these credentials were passed in Jenkins though. More on that later.]*
     - `rds.tf`: *[This was the file showing housing how the RDS was to be created - with which infrastructure specifics.]*
     - `security.tf`: *[This was the file with the security groups controlling the ingress and egress traffic for all 4 EC2s and the RDS instance.]*
     - `variables.auto.tf`: *[This declared the region in which the infrastructure was to be placed in and the type of EC2s]*
     - `variables.tf`: *[This declared the variables that surface anywhere within the above .tf files, plus the credentials passed from Jenkins]*

3. **CI/CD Pipeline Implementation**:
   - Integrated Jenkins to automate the deployment pipeline. The stages include:
     - **Build**: Compiling the application code.
     - **Test**: Running pre-defined tests to ensure code quality.
     - **Init, Plan, and Apply**: Utilizing Terraform commands to initialize, plan, and apply the infrastructure changes, ensuring the infrastructure is built according to the defined specifications.

4. **Scripting for Automation**:
   - Created user data scripts that configure the frontend and backend EC2 instances during their creation. This automation streamlines the deployment process by automatically installing dependencies and configuring environment settings.

5. **Environment Variable Management**:
   - Used Jenkins Secret Manager to handle sensitive information, such as AWS credentials, ensuring security and compliance.

6. **Monitoring Setup**:
   - Deployed an additional EC2 instance for monitoring purposes to track the health and performance of the deployed resources.

7. **Documentation**:
   - Created a comprehensive README file documenting the process, challenges faced, and potential optimizations for future iterations.

## System Design Diagram
*Insert System Design Diagram here*

## Issues/Troubleshooting
- **Instance Configuration Issues**: Initially faced challenges with incorrect security group settings that prevented communication between the frontend and backend EC2s. This was resolved by correctly configuring the security groups to allow necessary traffic.
- **Database Connection Errors**: Encountered issues connecting to the RDS database due to incorrect environment variable settings. This was rectified by ensuring that the settings in `settings.py` were appropriately configured.

## Optimization
- Future improvements could include:
  - Implementing more advanced monitoring solutions to provide insights into application performance.
  - Considering the use of containerization (e.g., Docker) for the application deployment to simplify dependency management and scaling.
  - Automating the database migrations further within the CI/CD pipeline for smoother updates and changes.

## Business Intelligence
- Questions to consider:
  - How can the deployment pipeline be enhanced to reduce downtime during updates?
  - What additional metrics can be collected to improve user experience?
  - How can we ensure data security and compliance in our deployment?

## Conclusion
This workload showcases the power of Terraform and Jenkins in automating the deployment process, providing a robust and scalable infrastructure for an ecommerce application. By leveraging IaC principles, we can ensure consistent environments and streamline updates, paving the way for more efficient development practices.

*Insert any additional sections you find relevant here.*
