#resourceblock.tf
resource "aws_instance" "virtual_server" {
    #ami stands for amazon machine image.where we select the operating system(os) of our virtual server
    ami = "ami-0f58b397bc5c1f2e8"
    #type of the instance
    instance_type = "t2.micro"
    key_name = "terraform"
    tags = {
      Name = "virtual_server_1"
    }
  
} 

