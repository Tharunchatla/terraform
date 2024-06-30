resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-1.id
}
resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
}

resource "aws_route_table" "rtw" {
    vpc_id = aws_vpc.vpc-1.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "rts" {
    subnet_id = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.rtw.id
}
resource "aws_security_group" "sg-1" {
    name = "sg_1"
    vpc_id = aws_vpc.vpc-1.id
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
resource "aws_instance" "server-1" {
    ami = "ami-04f8d7ed2f1a54b14" 
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet-1.id
    associate_public_ip_address = true
    key_name = "terraform"
    vpc_security_group_ids = [aws_security_group.sg-1.id]
    user_data = file("userdata1.sh")
    tags = {
        name = "nginx-server"
    }
}
