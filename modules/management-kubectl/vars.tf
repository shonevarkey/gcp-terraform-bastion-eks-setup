variable "project_id_kubectl" {
  description = "Name of Project"
  type        = string
}

variable "vpc_id" {
  description = "VPC Network ID"
  type        = string
}

variable "kubectl_name" {
  description = "ubectl Instance Name"
  type        = string
}

variable "kubectl_instancetype" {
  description = "Kubectl Instance Type"
  type        = string
}

variable "zone_kubectl" {
  description = "The zone for GCP resources"
  type        = string
}

variable "kubectl_image" {
  description = "Kubectl Image"
  type        = string
}

variable "kubectl_volumesize" {
  default = "Kubectl Persistent Disks volume size"
  type    = string
}

variable "kubectl_user" {
  default = "SSH User Key "
  type    = string
}

variable "kubectl_subnet" {
  description = "kubectl subnet"
  type        = string
}

