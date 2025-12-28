output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_vpc_test" {
  value = resource.aws_vpc.vpc1
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "aws_subnet_public_subnet" {
  value = resource.aws_subnet.public_subnet
}

output "aws_subnet_private_subnet" {
  value = resource.aws_subnet.private_subnet
}

output "aws_internet_gateway_igw_1" {
  value = resource.aws_internet_gateway.igw_1
}

output "aws_route_table_public_rt" {
  value = resource.aws_route_table.public_rt
}