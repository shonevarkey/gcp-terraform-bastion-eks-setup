variable "project_id_gke" {
  description = "The GCP project ID where the GKE cluster will be created"
  type        = string
}

variable "location" {
  description = "The location where the GKE cluster will be deployed"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "network" {
  description = "The VPC network where the GKE cluster will be deployed"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork where the GKE cluster will be deployed"
  type        = string
}

variable "node_pool_config" {
  description = "Configuration for GKE node pools"
  type = map(object({
    machine_type = string
    min_count    = number
    max_count    = number
    auto_upgrade = bool
  }))
}
