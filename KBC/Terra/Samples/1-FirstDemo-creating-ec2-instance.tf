resource "aws_instance" "First_demo" {
  #ubuntu-os
  ami = "ami-0620d12a9cf777c87"
  instance_type = "t2.micro"

  tags = {
    Name = "demoInstance"
  }
}
