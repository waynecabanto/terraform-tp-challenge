variable "vpc_id" {
  description = "Define the VPC ID"
  type        = string
}

variable "private_subnet_name" {
  description = "Private subnet name"
  type        = string
}

variable "public_subnet_name" {
  description = "Public subnet name"
  type        = string
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "nat_gw_name" {
  description = "NAT Gateway name"
  type        = string
}

variable "public_cidr_block" {
  description = "The CIDR block for the public subnet."
  type        = string
}

variable "private_cidr_block" {
  description = "The CIDR block for the private subnet."
  type        = string
}

variable "public_availability_zone" {
  description = "The availability zone to create the public subnets in."
  type        = string
}

variable "private_availability_zone" {
  description = "The availability zone to create the private subnets in."
  type        = string
}

variable "internet_gateway_id" {
  description = "The VPC IGW ID."
  type        = string
}

variable "private_route_table_name" {
  description = "Private subnet route table name."
  type        = string
}

variable "public_route_table_name" {
  description = "Public subnet route table name."
  type        = string
}
