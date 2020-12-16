# See https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html

resource "aws_vpc" "tfpoc-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
#   tags {
#     Name = "tfpoc-vpc"
#   }
}

# Subnet
resource "aws_subnet" "tfpoc-subnet-main" {
  cidr_block = "10.0.0.0/24"
  vpc_id = "${aws_vpc.tfpoc-vpc.id}"
  availability_zone = "us-east-2a"
}

# Security Group
resource "aws_security_group" "ingress-all-tfpoc" {
    name = "ingress-all-tfpoc"
    vpc_id = "${aws_vpc.tfpoc-vpc.id}"
    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
// Terraform removes the default rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# IGW
resource "aws_internet_gateway" "tfpoc-igw" {
  vpc_id = "${aws_vpc.tfpoc-vpc.id}"
# tags {
#     Name = "tfpoc-igw"
#   }
}

# Subnets
resource "aws_route_table" "route-table-tfpoc" {
  vpc_id = "${aws_vpc.tfpoc-vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tfpoc-igw.id}"
  }
# tags {
#     Name = "route-table-tfpoc"
#   }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.tfpoc-subnet-main.id}"
  route_table_id = "${aws_route_table.route-table-tfpoc.id}"
}

# Elastic IP for EC2 instance
# HACK: Need to put the remote-exec stuff here so TF provisioner can find the 
#   EIP public IP to connect to. This is the only way it seems to work.
# See: https://github.com/hashicorp/terraform/issues/6394. 
resource "aws_eip" "ip-tfpoc" {
    instance = "${aws_instance.tfpoc-ec2.id}"
    vpc      = true

    connection {
        type        =  "ssh"
        #host        =  self.public_ip
        host        = "${self.public_ip}"
        user        = "fedora"
        private_key = file("~/ssh-keys/tf-poc.pem")
    }

    # Apply all updates
    provisioner "remote-exec" {
        inline = ["sudo dnf update -y"]
    }
}