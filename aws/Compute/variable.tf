variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}

variable "instance_count" {
  description = "The number of instances to deploy"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "The type of instance to deploy"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default = {
    Testing   = "Compute_Testing",
    CreatedBy = "Nikith_Via_Terraform"
  }
}