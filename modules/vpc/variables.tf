variable "vpc_name" {
  description = "The name of the new VPC"
  type = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the new VPC"
  type = string
}

variable "subnets" {
  description = "A map of subnet name(s) and their CIDR blocks that should be added to the VPC"
  type = map(string)
  default = {}
}

variable "security_groups" {
  description = "An optional set of security groups to be created"
  type = set(string)
  default = []
}

variable "internet_gateway" {
  description = "A boolean flag which if true will trigger the creation of an Internet Gateway resource in the VPC"
  type = bool
  default = false
}

variable "tags" {
  description = "An optional map of tags that will be added to all created AWS resources"
  type = map(string)
  default = {}
}
