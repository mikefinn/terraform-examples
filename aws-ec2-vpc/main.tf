resource "aws_instance" "tfpoc-ec2" {
     ami           = "${var.aws_ec2_ami}"
     instance_type = "${var.aws_ec2_instance_type}"
     key_name = "${var.aws_ec2_keyname}"
     security_groups = ["${aws_security_group.ingress-all-tfpoc.id}"]
     subnet_id = "${aws_subnet.tfpoc-subnet-main.id}"

    #  tags {
    #      Name = "tfpoc-ec2"
    #  }




}