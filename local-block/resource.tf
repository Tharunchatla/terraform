#local block is used to define local variable in the module
#define local variable within terraform configuration
locals {
  ami_id = "ami-04f8d7ed2f1a54b14"
  instance_type = "t2.micro"
}
resource "aws_instance" "virtual_server" {
    ami = local.ami_id
    instance_type = local.instance_type
    key_name = "terraform"
    tags = {
        name = "virtual_server-1"
    }
}
