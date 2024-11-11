variable "project_id1" {
  description = "Name of Project"
  type        = string
}

variable "vpc_id" {
  description = "VPC Network ID"
  type        = string
}

variable "bastion_name" {
  description = "Bastion Instance Name"
  type        = string
}

variable "bastion_instancetype" {
  description = "Bastion Instance Type"
  type        = string
}

variable "zone3" {
  description = "The zone 3 for GCP resources"
  type        = string
}

variable "bastion_image" {
  description = "Bastion Image"
  type        = string
}

variable "bastion_volumesize" {
  default = "Bastion Persistent Disks volume size"
  type    = string
}

variable "bastion_user" {
  default = "SSH User Key "
  type    = string
}

variable "bastion_subnet" {
  description = "Bastion subnet"
  type        = string
}

