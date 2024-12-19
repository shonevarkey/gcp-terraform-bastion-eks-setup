# Firewall rules for the management VPC

# Inbound SSH access to bastion host from the internet
resource "google_compute_firewall" "allow_ingress_bastion_ssh" {
  name    = "allow-ingress-bastion-ssh"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"] # Allow from anywhere
  priority      = 1000
  target_tags   = ["management-bastion"]
}

# Outbound traffic from bastion to anywhere
resource "google_compute_firewall" "allow_egress_bastion" {
  name    = "allow-egress-bastion"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"] # To anywhere
  priority           = 1000
  target_tags        = ["management-bastion"]
}

# Inbound SSH access from bastion to kubectl instance in private subnet
resource "google_compute_firewall" "allow_ingress_kubectl_ssh" {
  name    = "allow-ingress-kubectl-ssh"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["${module.mgt_bastion.bastion_privateip}"]
  priority      = 1000
  target_tags   = ["kubectl"]
}

# Outbound traffic from kubectl instance to the internet via NAT Gateway
resource "google_compute_firewall" "allow_egress_kubectl_nat" {
  name    = "allow-egress-kubectl-nat"
  network = module.mgt_vpc.vpc_network_id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"] # To anywhere
  priority           = 1000
  target_tags        = ["kubectl"]
}

