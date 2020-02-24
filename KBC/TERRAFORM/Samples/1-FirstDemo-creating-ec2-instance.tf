resource "aws_instance" "First_demo" {

  #count = 3  #Creates 3 Instances
  #If we dont use the 'count'. By default it creates only one Instance
  count = 1
  ami = "ami-0620d12a9cf777c87" #ubuntu-os
  instance_type = "t2.micro"

  tags = {
    Name = "demoInstance"
    #Name = "demoInstance-${count.index}" #To name the instance dynamically.
    #If we don't use '${count.index}' . Then it creates all the instances with
    #same TAG name.
  }

}
