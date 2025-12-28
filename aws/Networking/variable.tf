variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidr_block" {
  description = "The public CIDR block for the VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_cidr_block" {
  description = "The private CIDR block for the VPC"
  type        = string
  default     = "10.0.2.0/24"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default = {
    Name      = "vpc1",
    CreatedBy = "Nikith_Via_Terraform"
  }
}