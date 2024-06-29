#variable block holds or store the value of sensitive data 
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "type of the instance to be launched"
}
