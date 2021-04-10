# Challenge 1

A 3 tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.

-------------------------------------------------------------------------------------------------------

VPC creation
Internet Gateway
NAT Gateway
Public and Private subnets
Two Route Tables
Security Groups
NACLs
~~Internet and Internal LB~~
~~Auto Scaling Groups~~
~~Launch configuration~~
~~Bastion Host creation~~

Above are the resources I've created using Terraform to have a vanila VPC to begin with. I have not created the one with strikethrough yet as it depends on the application nature and requirement. 

I've chosen Terraform to provision the infrastructure so as to extend the support for multiple cloud platform which is an option if the organisation choose to.

Note: I haven't run the terraform code, those are the code modules which has been added to create the resources. The file structuring and segregation enables better code maintenance and readability.

Having one account per environment is the way forward to have an isolated testing in an environment and get the sign offs before promoting it to the production.

Though I've created NAT gateway's in the public subnet to allow for the auto-updates, I choose to recreate the servers with the latest AMI every month as a best practise.

Created Port 80 ingress as part of NACL's as a general rule, but ideally only Port 443 should be allowed and offload to 80 at ELB

Created only in one AZ, but obviously need to have the replicas in minimum 3 AZ's in the production to fulfill one of the fundamentals of cloud i.e., Fault Tolerant

-------------------------------------------------------------------------------------------------------

VPC Design:
https://docs.aws.amazon.com/quickstart/latest/vpc/images/quickstart-vpc-design-fullscreen.png

Four fundamental philosophies of Cloud I believe are

1. High availability
2. Fault Tolerant
3. Scalability
4. Elasticity