# Terraform Task

## Questions

If you have any questions regarding this task please reply to the initial email you received.

## Credentials

You will be supplied with a username/password to complete this task. This user will provide you Administrator access to your own 
AWS account, you will be expected to create any/all required IAM permission in order to deploy the required infrastructure.

* AWS Login URL: Refer to email
* Username: Refer to email
* Password: Refer to email

## Tasks

### 1. Create VPC Module

Your first task is to create a reusable module to provison a new VPC.

Please complete the following files in the `modules/vpc` subfolder:

* main.tf
* output.tf

Input variables for the module are already defined in `variables.tf` file.

**Where any provisioned resource requires values that are not specifically passed as variables please hard-code sensible default values.** 

### 2. Create Aurora RDS MySQL Database Module

Your second task is to create a reusable Terraform module to provision an RDS Aurora MySQL database in AWS.

Please complete the following files in the `modules/database` subfolder:

* main.tf
* output.tf
* variables.tf

The module should accept the following variables:

* database name
* database port
* master username
* one or more security group id(s)
* one or more subnet id(s)
* optional list of tags to be added to all provisioned resources
* the name of the SSM parameter that will be used to store the master user password

The module should generate a random master user password and store this value in SSM parameter store. The name of this 
SSM parameter should come from the module input variable.

**Where any provisioned resource requires values that are not specifically passed as variables (e.g. instance sizes, backup frequency) 
please hard-code sensible default values.**
 
### 3. Deploy using the modules
    
Your third task is to use both of the modules you have just created and deploy this infrastructure using the provided
`main.tf` file in this folder.

Deployment should be completed using Terraform CLI on your workstation (you will be provided with an IAM key/secret). 

### 4. Submission

Once the example VPC/database have been successfully provisioned in AWS, please submit all Terraform files including the 
provisioned `.tfstate` file via a ZIP file as a reply to the initial email you received.