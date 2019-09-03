variable "mongo_vpc" {
  default = "vpc-0859fd8be0cdfed71"
}

# marksons AMI
# variable "my_ami" {
#   default = "ami-1bd9c57f"
# }

variable "my_ami" {
  default = "ami-074fc8a39964ce658"
}

variable "cidr_block_number" {
  default = ["0.0.0.0/0"]
}


variable "my_region" {
  default = "eu-west-1"
}
# 
# variable "gateway" {
#   default = "igw-01f0943da9e898753"
# }
#
# varibale "route_table" {
#   default = "rtb-0ea1bb9d6912cd018"
# }
