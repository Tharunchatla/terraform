resource "aws_instance" "server" {
    ami = "ami-04f8d7ed2f1a54b14"
    instance_type = "t2.micro"
    key_name = "terraform"
    tags = {
        Name = "server-1"
    }
  
}
output "instance_public_ip" {
    value = aws_instance.server.public_ip
}
