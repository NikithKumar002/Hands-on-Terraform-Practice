data "aws_caller_identity" "current" {}

resource "aws_vpc" "vpc1" {
  region               = var.region
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

data "aws_availability_zones" "available" {
  region = var.region
  state  = "available"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "public_subnet" })
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.private_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
  tags              = merge(var.tags, { Name = "private_subnet" })
}

resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.vpc1.id
  tags   = merge(var.tags, { Name = "igw_1" })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1.id
  }
  tags = merge(var.tags, { Name = "public_rt" })
}
