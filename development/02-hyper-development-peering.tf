data "google_compute_network" "mgmt_vpc" {
  name = "vpc-management-hyper-us-central1"
}

# VPC Peering connection from development-vpc to management-vpc
resource "google_compute_network_peering" "development_to_management" {
  name         = "dev-to-mgmt"
  network      = module.dev_vpc.vpc_network_id
  peer_network = data.google_compute_network.mgmt_vpc.id # Reference the ID of the management VPC network
}


# Allow traffic from management VPC to development VPC
resource "google_compute_firewall" "allow_ingress_from_management" {
  name    = "allow-ingress-from-management"
  network = module.dev_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["10.10.0.0/16"] # Allow traffic from management VPC
  priority      = 1000
  target_tags   = ["development-vpc"]
}

# Allow traffic from development VPC to management VPC
resource "google_compute_firewall" "allow_egress_to_management" {
  name    = "allow-egress-to-management"
  network = module.dev_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["10.10.0.0/16"] # Allow traffic to management VPC
  priority           = 1000
  target_tags        = ["development-vpc"]
}
