# TechChallenge

## Introduction:

This repository was created to implement the coding challenge provided by Servian.
This README will guide you through the prerequisites, the steps to deploy the application, and the AWS cloud platform architecture that is being used. 

There are 2 ways you can trigger this automated setup.

1. Using GitLab CI/CD.
2. Using linux shell script.

# Using GitLab CI/CD

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
5. Select Expand in the Variables section. Add below variables and their values into that section.
    1.1 AWS_ACCESS_KEY_ID
    1.2 AWS_REGION
    1.3 AWS_SECRET_ACCESS_KEY
    1.4 PROJECT_ID (This is the GitLab project ID)
    1.5 TF_PASSWORD (This is a personal access token with the permission to api, read_api, read_user, read_repository, write_repository, read_registry, write_registry)
    1.6 TF_USERNAME (Username of your GitLab account)





