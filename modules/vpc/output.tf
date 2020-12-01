output "vpc_id" {
  description = "The VPCs AWS resource ID"
  # Replace example output below
  # type = string
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  # Replace example output below
  # type = string
  value = aws_vpc.vpc.cidr_block
}

output "cidr_blocks" {
  description = "The CIDR blocks of all subnets that were created in a map indexed by a unique string identifier based on the subnet type and availability zone"
  # Replace example output below
  # type = map(string)
  value = {
     for name, cidr in var.subnets:
     name => aws_subnet.subnet[name].cidr_block
  }
}

output "subnet_ids" {
  description = "The AWS resource IDs of all subnets that were created in a map indexed by a unique string identifier based on the subnet type and availability zone"
  # Replace example output below
  #type = map(string)
  #value = aws_subnet.subnet[1].id
  value = {
       for name, cidr in var.subnets:
       name => aws_subnet.subnet[name].id
  }
}

output "security_group_ids" {
  description = "The AWS resource IDs of all security groups that were created indexed by their supplied map index"
  # Replace example output below
  # type = map(string)
  value = {
    for name in var.security_groups:
    name => aws_security_group.securitygroup[name].id
  }
}

output "internet_gateway_id" {
  description = "The AWS resource ID of the Internet Gateway (if applicable) that was created"
  # Replace example output below
  # type = string
  value = join("",aws_internet_gateway.igw[*].id)
}