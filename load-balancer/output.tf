output "server-1_public_ip" {
    description = "The public IP address of the server instance" #optional
    value = aws_instance.server-1.public_ip
}
output "server-2_public_ip" {
    value = aws_instance.server-2.public_ip
}
output "load_balancer_dns_name" {
  value = aws_lb.lb.dns_name
}
