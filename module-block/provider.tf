provider "aws" {
    region = "ap-south-1"
    profile = "default"
}
module "nginx_server-1" {
   source = ".//module-1"
}
module "apache_server-2" {
   source = ".//module-2"
}
