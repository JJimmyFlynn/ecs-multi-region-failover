locals {
  az_count = 3
}

/****************************************
* Base VPC
*****************************************/
resource "aws_vpc" "default" {
  enable_dns_hostnames = true
  cidr_block           = "10.10.0.0/16"
}

/****************************************
* Subnets
*****************************************/
resource "aws_subnet" "private" {
  count             = local.az_count
  vpc_id            = aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(aws_vpc.default.cidr_block, local.az_count, count.index)
}

resource "aws_subnet" "public" {
  count             = local.az_count
  vpc_id            = aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(aws_vpc.default.cidr_block, local.az_count, count.index + local.az_count) // pickup where private subnet creation left off
}

/****************************************
* Internet Gateway
*****************************************/
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

/****************************************
* Route Tables
*****************************************/
// PUBLIC WEB ACCESS
resource "aws_route_table" "web_access" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
}

resource "aws_route_table_association" "web_access" {
  count          = local.az_count
  route_table_id = aws_route_table.web_access.id
  subnet_id      = aws_subnet.public.*.id[count.index]
}
