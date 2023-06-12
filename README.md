# helloworld-EC2-CICD
Deploy simple Spring Boot Hello World application on EC2 using Terraform and Jenkins
1. Java code is in src folder
2. The terraform code is in Terraform folder
   - The application is to be deployed on HelloWorld_EC2_instance. The code for this instance is in compute module
   - The Jenkins server is installed on Jenkins EC2 instance and the code for this is in jenkins_instance module
   - The security infrastructure is built under the networking module.
   - Terraform Cloud is used to manage the states and resources created with the code above.
3. Set up infrastructure:
   - terraform init  # Initializes the Terraform Cloud and downloads the provider plugins
   - terraform plan  # Shows the plan and the changes that will be applied on apply
   - terraform apply # Applies the infrastructure changes which were shown in the plan

4. Access and setup Jenkins server:
   - Connect the jenkins_instance and access the Jenkins server 
    Link: http://IPv4 public_IP:8080 
   - Login using Administrative password







STAGE III: Create another EC2 instance in AWS on which Jenkins is to be installed using Bash script