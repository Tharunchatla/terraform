resource "aws_instance" "server" {
    ami = data.aws_ami.amazonlinux.id
    instance_type = var.instance_type
    key_name = "terraform"
    tags = {
        name = "virtual-server"
    }
}