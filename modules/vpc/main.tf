# Create Terraform module here
resource "aws_vpc" "vpc" {

  cidr_block  = var.vpc_cidr_block
  
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.tags
  )
}


resource "aws_subnet" "subnet" {
    for_each = var.subnets
    vpc_id     = aws_vpc.vpc.id
    cidr_block = each.value

    availability_zone = data.aws_availability_zones.available.names[index(keys(var.subnets),each.key) % length(data.aws_availability_zones.available)]
    
    map_public_ip_on_launch = each.key == "public" ? true : false
    tags = merge(
      {
        Name = each.key
      },
      var.tags
   )
}

resource "aws_security_group" "securitygroup" {
  
  for_each = var.security_groups
  name = each.value
  vpc_id     = aws_vpc.vpc.id

  tags = merge(
    {
      Name = each.value
    },
    var.tags
  )
}

resource "aws_internet_gateway" "igw" {
  count = var.internet_gateway == true ? "1":"0"
  vpc_id = aws_vpc.vpc.id
  tags = var.tags
}

data "aws_availability_zones" "available" {}


resource "aws_route_table" "public_route_table" {
  count = var.internet_gateway == true ? "1":"0"

  vpc_id = aws_vpc.vpc.id

  tags = var.tags
}

resource "aws_route" "public_internet_gateway" {
  count = var.internet_gateway == true ? "1":"0"

  route_table_id         = aws_route_table.public_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id

  timeouts {
    create = "5m"
  }
}


resource "aws_route_table_association" "public" {
  count = var.internet_gateway == true ? "1":"0"

  subnet_id      = aws_subnet.subnet["public"].id
  route_table_id = aws_route_table.public_route_table[0].id
}