
resource "aws_s3_bucket" "terraform-s3" {

   bucket = "terraform-s3-testing" #give your own unique name
   #This name should be unique across AWS, otherwise bucket can't be created.

   versioning {
     enabled = true
   }

   lifecycle {
     prevent_destroy = true # resource can't be deleted
     #prevent_destroy = false # resource can be deleted
   }

   tags = {
     Name = "S3 Remote Store"
   }
}
