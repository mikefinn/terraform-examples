output "public-ip" {
  description = "Public IP address"
  value       = "${aws_eip.ip-tfpoc.public_ip}"
}

output "public-hostname" {
  description = "Public hostname"
  value       = "${aws_eip.ip-tfpoc.public_dns}"
}