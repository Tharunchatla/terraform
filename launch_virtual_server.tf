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
/*By using terraform

-launching a virtual server(EC2)

Process to be followed

step:1 Install terraform from official Terraform website

step:2 install unzip and aws cli 

step:3 configure aws by using AWS Access Key ID, Secret Access Key, default region, and output format(command : aws configure)

step:4 Create a directory terraform(command : mkdir terraform | cd terraform)

step:5 create a terraformblock.tf file using touch command and add data to file using  command : cat >> terraformblock.tf

[ 

terraform {

  required_providers {

    aws = {

      source = "hashicorp/aws"

      version = "5.55.0"

    }

  }

}

]

step:6 create a provider.tf file by using command touch and add data to file using command cat >> provider.tf

data[

provider "aws" {

  region = "ap-south-1" # based on your region

  profile = "default" 

}

]

step:7 create a resource.tf file by using command touch and add data to file using command cat >> resource.tf

data[

resource "aws_instance" "virtual_server" {

    #ami stands for "amazon machine image" where we select the operating system(os) of our virtual server

    ami = "ami-0f58b397bc5c1f2e8"

    #type of the instance

    instance_type = "t2.micro"

    key_name = "terraform"

    tags = {

      Name = "virtual_server_1"

    } 

}

]  

step:7 Initialize the Terraform using command (terraform init)

step:8 create the resource by using command (terraform apply)

step:9 To terminate instance use command(terraform destroy)
*/
