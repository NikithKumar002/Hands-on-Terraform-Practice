variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 10
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default = {
    Testing   = "Block_Storage_Testing",
    CreatedBy = "Nikith_Via_Terraform"
  }
}