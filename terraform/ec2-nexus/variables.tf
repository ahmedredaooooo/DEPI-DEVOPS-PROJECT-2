variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type for Nexus"
  default     = "t3.small"
}

variable "ami" {
  description = "Ubuntu 22.04 AMI"
  default     = "ami-0dc2d3e4c0f9ebd18" # Update based on region
}

variable "key_name" {
  description = "SSH key name in AWS"
  type        = string
}

