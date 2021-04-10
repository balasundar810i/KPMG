variable "region" {
    description = "AWS region"
    type = string
    default = "eu-west-1"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type = string
}

variable "private_subnet" {
  description = "Private subnet CIDR block"
  type = string
}

variable "public_subnet" {
  description = "Public subnet CIDR block"
  type = string
}

variable "az1" {
  description = "Availability zone 1"
  type = string
  default = "eu-west-1a"
}

variable "az2" {
  description = "Availability zone 2"
  type = string
  default = "eu-west-1b"
}

variable "az3" {
  description = "Availability zone 3"
  type = string
  default = "eu-west-1c"
}