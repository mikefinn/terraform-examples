# terraform-examples

# Collection of examples using Terraform with AWS

## General instructions for each
### Prerequisites
1. AWS account
2. AWS user provisioned with sufficient privs to provision resources. You can accomplish this by creating a group with AdministratorAccess policy, and adding the user to that group. NOTE: This is good for development, but not production. You should create a custom IAM policy with the specific resource permissions you need.
3. Terraform installed wherever you are going to run these scripts. Note v0.14 or higher is required. Download at https://www.terraform.io/downloads.html. The steps below assume terraform is in your path.

### Executing examples
1. `$ terraform init`
2. `$ terraform plan`
3. `$ terraform apply`
When done with resources, run the following to keep your AWS bill from running away from you
4. `$ terraform destroy`

## Examples

### aws-ec2-vpc
Basic example of EC2 and VPC
Builds an EC2 instance inside a public subnet, inside a VPC. Port 22 allowed from Internet to host. Once instance is done being build, OS updates are applied.
