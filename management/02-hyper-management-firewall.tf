resource "google_compute_firewall" "allow_bastion_ingress" {
  name    = "allow-ssh-bastion-ingress"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]
}

resource "google_compute_firewall" "allow_kubectl_egress" {
  name    = "allow-kubectl-egress"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["kubectl"]
}

resource "google_compute_firewall" "allow_inter_vpc" {
  name    = "allow-management-to-development"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["10.20.0.0/16"] # Development VPC range
  target_tags   = ["kubectl"]
}
