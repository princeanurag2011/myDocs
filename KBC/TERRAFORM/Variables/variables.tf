variable "ami_type" {
  default = {
    type = "map"
    us-east-1 = ami-0c322300a1dd5dc79
    ap-south-1 = ami-0620d12a9cf777c87
  }
}

variable "env" {
  #If we don't specify any value. It ask when we run terraform plan
}

variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  type = map
  default = {
    dev = t2.micro
    test = t2.medium
  }
}

variable "sgs" {
  type = list
  default = ["sg-168bd849"]
}
