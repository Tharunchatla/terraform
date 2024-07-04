/*provider "aws" {
    region = "ap-south-1"
    profile = "default"

}*/
resource "aws_vpc" "vpc" {
    cidr_block = "18.0.0.0/16"
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}
resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "18.0.1.0/24"
    availability_zone = "ap-south-1a"
}
resource "aws_subnet" "subnet_2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "18.0.2.0/24"
    availability_zone = "ap-south-1b"
}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = "aws_internet_gateway.igw.id"
    }
}
resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.subnet_1
    route_table_id = aws_route_table.rt
}
resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.subnet_2
    route_table_id = aws_route_table.rt
}
resource "aws_instance" "server-1" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = "terraform"
    subnet_id = aws_subnet.subnet_1.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sg1.id]
    user_data = file("userdata1.sh")
    tags = {
      Name = "server-1"
    }
}
resource "aws_instance" "server-2" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = "terraform"
    subnet_id = aws_subnet.subnet_2.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sg1.id]
    user_data = file("userdata2.sh")
    tags = {
      Name = "server-2"
    }
}
resource "aws_security_group" "sg1" {
    vpc_id = aws_vpc.vpc.id
    #allow ssh
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      #allow http
   ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_lb" "lb" {
  name               = "lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg1.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

}

resource "aws_lb_target_group" "target_group" {
  name     = "example-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_target_group_attachment" "server-1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.server-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "server-2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.server-2.id
  port             = 80
}