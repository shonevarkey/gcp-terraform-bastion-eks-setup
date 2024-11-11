
variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "subnet1_cidr" {
  description = "Subnet1 CIDR"
  type        = string
}

variable "subnet1_name" {
  description = "Public Subnet Name"
  type        = string
}

variable "zone1" {
  description = "The zone 1 for GCP resources "
  type        = string
}

variable "zone2" {
  description = "The zone 2 for GCP resources"
  type        = string
}

variable "region" {
  description = "The region for GCP resources"
  type        = string

}
variable "subnet2_cidr" {
  description = "Subnet2 CIDR"
  type        = string
}

variable "subnet2_name" {
  description = "Public Subnet Name"
  type        = string
}

variable "subnet3_cidr" {
  description = "Subnet3 CIDR"
  type        = string
}

variable "subnet3_name" {
  description = "Private Subnet Name"
  type        = string
}

variable "public_route_name" {
  description = "Default public route table name"
  type        = string
}


