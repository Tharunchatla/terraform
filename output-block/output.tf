output "instance_public_ip" {
    description = "The public IP address of the server instance" #optional
    value = aws_instance.server.public_ip
}