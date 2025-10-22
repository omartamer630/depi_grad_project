variable "region" {
  description = "The Region that i will implement my Infra in AWS"
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"
}

variable "assoicated_project" {
  description = "The Project that infrastructure host"
  type        = string
  default     = "project"
}

variable "cidr_block" {
  description = "The CIDR block for the Network"
  type = string
}

variable "az" {
  description = "The Availability Zone for the Subnet"
  type        = list(string)
}

variable "ecr_name" {
  description = "Contains the image name"
  type = string
}
