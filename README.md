# **TechChallenge**

## Introduction:

This repository was created to implement the coding challenge provided by Servian.
This README will guide you through the prerequisites, the steps to deploy the application, and the AWS cloud platform architecture that is being used. 

There are 2 ways you can trigger this automated setup.

1. Using GitLab CI/CD.
2. Using linux shell script.

# **Using GitLab CI/CD**

## Tools used:

- AWS public cloud as infrastructure
- Terraform (version 1.2.6)
- GitLab CI/CD as automation tool

## Prerequisites:

- You should have an AWS account and should have programmatic access to it with permission to deploy network resources, RDS instances, EC2 instances, KMS keys, AWS service linked roles, IAM policies, application load balancers, and assigning policies to roles.
- You should have an GitLab account.

## Steps to deploy the application:

1. Login to your GitLab account.
2. Create a new project.
3. Add this repository's code into your repository.
4. In the left side pane, select Settings>CI/CD.
5. Select Expand in the Variables section. There add below variables and their values into that section.
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * PROJECT_ID (This is the GitLab project ID)
    * TF_PASSWORD (This is a personal access token with the permission to api, read_api, read_user, read_repository, write_repository, read_registry, write_registry)
    * TF_USERNAME (Username of your GitLab account)

**Note:** Here all other variables except TF_USERNAME, and PROJECT_ID must be masked variables to improve security.

6. Go to CI/CD > Pipelines in left side pane and select Click on pipeline. Select main branch to run the pipeline.
7. In the variables section add AWS_REGION, and DB_SECRET_NAME as keys and add their values.
    * Here AWS_REGION is where you deploy the infrastructure. Currently configured to run in us-east-1 and us-east-2 only.
    * Here DB_SECRET_NAME is the name of the secret created in AWS secret manager to store database credentials and database endpoint information.
8. After the pipeline gets completed successfully login to your aws account and get the public DNS name of the Application Load Balancer that has been created and navigate to that dns zone in your browser to checkwhether the application is properly deployed.


# **Problems faced during deployment**

- [ ] The command that execute the database statement to create DB at initially gives an permission denied error when setting TABLESPACE to pg_default. This error could have been occurred due to PostgreSQL version being used. AWS RDS has deplricated both tested versions defined in the application and I have selected 10.17 version as it was the oldest version that was available.

*Error log collected from EC2 instance while startup*
![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/blob/release-1.0.0/images/userdata_log.PNG)

*Error log collected from RDS instance*
![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/blob/release-1.0.0/images/db_error_log.PNG)

# **AWS architecture after the deployment:**

![Image](https://gitlab.com/servian-lahiru/tech-challenge/-/blob/release-1.0.0/images/tech-challenge-architecture.png)








