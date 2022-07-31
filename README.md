# **TechChallenge**

## Introduction:

This repository was created to implement a coding challenge.
This README will guide you through the prerequisites, the steps to deploy the application, and the AWS cloud platform architecture that is being used. 

There are 2 ways you can trigger this automated deployment setup.

1. Using GitLab CI/CD.
2. Using linux shell script.

# **Using GitLab CI/CD**

Here the terraform backend is stored remotely in GitLab using it's in built feature. Implemented GitLab pipeline consists of 4 stages:

* lint (Checks whether terraform code syntax is valid or not)
* plan (Runs a terraform plan enabling user to foresee the reources getting created in the AWS cloud platform)
* apply (Runs a terraform apply to provision the AWS cloud resources resources)
* destroy (Destroys all the infrastructure created by previous apploy stage)

![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/raw/release-1.0.0/images/gitlab_stages.PNG)

**Note:** After running the plan stage user have to trigger the apply stage manually to run it. This is used to prevent the pipeline from provisioning cloud resources unless user want to. Same goes with destroy stage.

## Tools used:

- AWS public cloud as infrastructure provider
- Terraform (version 1.2.6)
- GitLab CI/CD as automation tool

## Prerequisites:

- You should have an AWS account and should have programmatic access to it with permission to deploy network resources, RDS instances, EC2 instances, KMS keys, AWS service linked roles, IAM policies, application load balancers, and assigning policies to roles.
- You should have an GitLab account.

## Steps to deploy the application:

1. Login to your GitLab account.
2. Create a new project.
3. Add this repository's code into your new project.
4. In the left side pane, select *Settings>CI/CD*.
5. Select Expand in the Variables section. There add below variables and their corresponding values into that section.
    - [ ] AWS_ACCESS_KEY_ID
    - [ ] AWS_SECRET_ACCESS_KEY
    - [ ] PROJECT_ID (This is the GitLab project ID)
    - [ ] TF_PASSWORD (This is the personal access token you have to create in GitLab with the permission to api, read_api, read_user, read_repository, write_repository, read_registry, write_registry)
    - [ ] TF_USERNAME (Username of your GitLab account)

**Note:** Here all other variables except *TF_USERNAME*, and *PROJECT_ID* must be masked variables to improve security.

6. Go to *CI/CD > Pipelines* in left side pane and select Click on pipeline. Select main branch to run the pipeline.
7. In the variables section add AWS_REGION, and DB_SECRET_NAME as keys and add their values.
    - [ ] Here *AWS_REGION* is where you deploy the infrastructure. Currently configured to run in *us-east-1* and *us-west-2* only.
    - [ ] Here *DB_SECRET_NAME* is the name of the secret created in AWS secret manager to store database credentials and database endpoint information. If you do not specify this name pipeline will set secret name as "tech_challenge_secret". But if you try to destroy the infrastructure and re deploy again in same cloud account you will have to specify *DB_SECRET_NAME* since AWS secret manager will delete removed secrets after minimum 7 days and newly creating secret name must not conflict with it.
8. After the pipeline gets completed successfully login to your aws account and get the public DNS name of the Application Load Balancer that has been created and navigate to that dns zone in your browser to validate the application is properly deployed.

# **Using shell script**

Here the terraform backend is stored in local machine's working directory.

## Tools used:

- AWS public cloud as infrastructure
- Terraform (version 1.2.6)
- Linux bash

## Prerequisites:

- You should have an AWS account and should have programmatic access to it with permission to deploy network resources, RDS instances, EC2 instances, KMS keys, AWS service linked roles, IAM policies, application load balancers, and assigning policies to roles.
- Should have a Linux terminal with bash.

## Steps to deploy the application:

1. Navigate into the tech-challenge directory.
2. Execute setup.sh with arguments
    - [ ] -r : region (Only tested in us-east-1 and us-west-2)
    - [ ] -d : database secret name (Store credentials in AWS secrets manager. Optional in first run. Reason explained in the 'Using GitLab' section).
    - [ ] -t : Terraform action to perform (Allowed values are validate, plan, apply, destroy)
    - [ ] -a : aws_access_key
    - [ ] -s : aws_secret_access_key

*Example:* ./setup.sh -r us-east-1 -d example_secret_name -t plan -a AWS_ACCESS_KEY_ID -s AWS_SECRET_ACCESS_KEY


# **Problems faced during deployment:**

* The command that execute the database statement to create DB at initially gives a permission denied error when setting *TABLESPACE* to *pg_default*. This error could have been occurred due to PostgreSQL version being used. AWS RDS has deprecated both tested versions defined in the application and I have selected 10.17 version as it was the oldest version that was available.

### **Error log collected from EC2 instance while startup:**
---
![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/raw/release-1.0.0/images/userdata_log.PNG)

### **Error log collected from RDS instance:**
---
![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/raw/release-1.0.0/images/db_error_log.PNG)

# **AWS architecture**

![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/raw/release-1.0.0/images/tech-challenge-architecture.jpg)


# **Security considerations taken:**

* Public subnets are used to allow the inbound traffic from internet where Application Load Balancer is placed which will then forward to it's private subnets where application VMs are placed.
* Application VMs and RDS instances are created in private subnetes where there will not be any access from internet.
* Application VMs are attached with a security group which will only allow traffic from load balancer to it's port 3000.
* RDS instances are attached with a security group which will only allow traffic from aplication VMs.
* Storages of RDS instances are encrypted at rest using a KMS key.
* AWS secret manager used to store database credentials and endpoint information.
* Password for database is randomly created with terraform when the infrastructure is provisioned.
* Application VMs are granted with IAM instance profile to access AWS secret manager to fetch db credentials while proviosning. 

# **High availability features implemented:**

* Application load balancer is spanned accross 2 availability zones.
* Auto scaling group which is used to deploy application is spanned across two subnets in two availability zones. 
* RDS deployed in one availability zone and two other read replicas are deployed in two other availability zones.


