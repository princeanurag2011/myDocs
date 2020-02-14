
#Terraform infrastructure Provisioning for AWS.

USED and TESTED with:
Terraform v0.12.20
+ provider.aws v2.49.0


#Download: https://www.terraform.io/downloads.html
#Provider help: https://www.terraform.io/docs/providers/aws/index.html

####MANDATORY TASK:
1. Create an EC2 Instance.
2. Create a Group in IAM
3. Create an IAM User
     - Give him programmatic Access and
     - Console Access.
4. Create Password Policy
5. Attach Password Policy to Newly created User and ADD him to the group.
6. Create a Role and attach it to the EC2 Instance
    for example:
        - if we want to provision EC2 Instance then,
        - create ROLE( it should have AmazonEC2FullAccess) and attach it to ec2-instance.
7. Connect to an EC2-instance in AWS using .pem file provided while creating it.
#### Now the user has both programmatic Access as well as Console Access.

#After connecting to the EC2-Instance, go to the home directory
sudo su;
cd;

#download terraform for ubuntu:
wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip

unzip -v terraform_0.12.20_linux_amd64.zip

#To add to Environment variables
export PATH=$PATH:/root

#To check the version
terraform version

#Create a directory
mkdir infraProvision

#Go to that directory
cd infraProvision

#To add plugins and Initialize a Terraform working directory
terraform init

# WE can provide AWS Access to Terraform in the following Ways:

 #AWS account options: ONLY OPTION 4 is RECOMMENDED Approach.

  1. Create IAM User with Programmatic Access and Use 'Access Key ID' and
    'Secret Access key' in 'provider.tf' as shown below.

  ####Sample provider file:
-------------------provider.tf------------------------------
  provider "aws" {
  access_key = "uaasdusaQL" #use your 'Access Key ID'
  secret_key = "u9d889su9s9d0" #use your 'Secret Access key'
  region = "ap-south-1" #The Region where you want to provision
  }
---------------------------------------------------

  2. Create IAM User with Programmatic Access pass through Environment variables:

      export AWS_ACCESS_KEY_ID="u9as8u8ADADFS9u89as89ua"  ##use your 'Access Key ID'
      export AWS_SECRET_ACCESS_KEY="98ASYD8AD99HH9suad0saud9s0" #use your 'Secret Access key'

  3. Storing it under  ~/.aws/


  4. Attach Admin Roles to Instance (RECOMMENDED)
      - create ROLE( it should have AmazonEC2FullAccess) and attach it to ec2-instance.

#Create the definition file with .tf extension
ex: vim 1-create-ec2-instance.tf
Use the below code in it to create a Single EC2 instance in AWS.
----------------------------------------------------
  resource "aws_instance" "First_demo" {
    #ubuntu-os
    ami = "ami-0620d12a9cf777c87"
    instance_type = "t2.micro"

    tags = {
      name = "demoInstance"
    }
  }
----------------------------------------------------

#To generate and show execution plan
terraform plan

####Troubleshooting:

   if the above command doesn't work. Then
   - check whether the logged in user has  programmatic access ?
       - if yes, then check whether the 'provider.tf' has the details?
         NOTE: provider.tf file should be present in the same working directory.
         ####sample provider file:
       ---------------------------------------------------
         provider "aws" {
         access_key = "uaasdusaQL" #use your access_key
         secret_key = "u9d889su9s9d0" #use your secret_key
         region = "ap-south-1" #The Region where you want to provision
         }
       ---------------------------------------------------
       NOTE: This is NOT A RECOMMENDED approach as it uses keys and stores them in
              the instance.

   - Any Role is attached to the connected EC2 Instance?
      - if not attach the role.
     NOTE:
       - If Roles are attached then,
          no need to use 'access_key' and 'secret_key' in 'provider.tf' file.
       - RECOMMENDED Way is to attach Roles.


#To Build the infrastructure plan and start Provisioning infrastructure.
terraform apply    

#To Destroy the  provisioned infrastructure.
terraform destroy
-------------------------------------------------------------------------
