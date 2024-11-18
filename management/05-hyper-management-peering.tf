data "google_compute_network" "dev_vpc" {
  name = "vpc-development-hyper-us-central1"
}

# VPC Peering connection from management-vpc to development-vpc
resource "google_compute_network_peering" "management_to_development" {
  name         = "mgmt-to-dev"
  network      = module.mgt_vpc.vpc_network_id
  peer_network = data.google_compute_network.dev_vpc.id # Reference the ID of the development VPC network
}

# Allow traffic from development VPC to management VPC
resource "google_compute_firewall" "allow_ingress_from_development" {
  name    = "allow-ingress-from-development"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["10.20.0.0/16"] # Allow traffic from development VPC
  priority      = 1000
  target_tags   = ["management-vpc"]
}

# Allow traffic from management VPC to development VPC
resource "google_compute_firewall" "allow_egress_to_development" {
  name    = "allow-egress-to-development"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["10.20.0.0/16"] # Allow traffic to development VPC
  priority           = 1000
  target_tags        = ["management-vpc"]
}
