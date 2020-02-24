
#This is used to retrieve data of availability_zones
data "aws_availability_zones" "available" {}


resource "aws_instance" "firstdemo" {

#These values are fetched from  variables.tf file
ami = "${lookup(var.ami_type,var.region)}"

#we can choose the availability_zone from retrieved data
availability_zone = "${data.aws_availability_zones.available.names[0]}"

#These values are fetched from  variables.tf file
security_groups = "${var.sgs}"

#These values are fetched from  variables.tf file
instance_type="${lookup(var.instance_type,var.env)}"

 tags {

   Name = "demoinstance"

 }

}
