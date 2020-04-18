
resource "aws_instance" "firstdemo" {
  ami = "${var.amitype}" #these values are read from variables.tf
  instance_type = "t2.micro"

  tags {
   Name = "demoinstance"
  }

}
