variable "aws_profile" {
    default = "terraform"
    description = "Name of AWS profile. Usually found in $HOME/.aws/credentials. Created in IAM and must have sufficient perms to create all resources."
}

variable "aws_region" {
    default = "us-east-2"
    description = "AWS region in which to create resources"
}

variable "aws_ec2_ami" {
    # Fedora-Cloud-Base-32-1.5.x86_64-hvm-us-east-2-gp2-0
    default = "ami-07be3f7c1c4f505ab"
    description = "AMI with which to create EC2 instance"
}

variable "aws_ec2_user" {
    default = "fedora"
    description = "Default user. Determined by AMI."
}

variable "aws_ec2_instance_type" {
    default = "t2.micro"
    description = "AWS instance type"
}

variable "aws_ec2_keyname" {
    default = "tf-poc"
    description = "SSH keypair name with which to access host."
}