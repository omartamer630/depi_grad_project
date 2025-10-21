variable "region" {
  description = "The Region that i will implement my Infra in AWS"
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"
}
