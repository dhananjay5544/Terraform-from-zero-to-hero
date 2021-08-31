resource "aws_instance" "web" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnetid      = "${var.subnet_id}"
  
  tags = {
    Name = "HelloWorld"
  }
}