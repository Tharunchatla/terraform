resource "aws_vpc" "vpc-2" {
    cidr_block = "20.0.0.0/16"
}
resource "aws_internet_gateway" "igw-2" {
    vpc_id = aws_vpc.vpc-2.id
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.vpc-2.id
    cidr_block = "20.0.1.0/24"
    availability_zone = "ap-south-1b"
}

resource "aws_route_table" "rtw-2" {
    vpc_id = aws_vpc.vpc-2.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-2.id
    }
}
resource "aws_route_table_association" "rts-2" {
    subnet_id = aws_subnet.subnet-2.id
    route_table_id = aws_route_table.rtw-2.id
}
resource "aws_security_group" "sg-2" {
    name = "sg_2"
    vpc_id = aws_vpc.vpc-2.id
    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "server-2" {
    ami = "ami-0f58b397bc5c1f2e8"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet-2.id
    associate_public_ip_address = true
    key_name = "terraform"
    vpc_security_group_ids = [aws_security_group.sg-2.id]
    user_data = file("userdata2.sh")
    tags = {
        name = "apache_server"
    }
}
