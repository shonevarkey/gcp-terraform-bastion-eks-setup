resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  #tags                    = ["${var.vpc_name}"]
}

resource "google_compute_subnetwork" "public_subnet1" {
  name          = var.subnet1_name
  ip_cidr_range = var.subnet1_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region
  #depends_on = [google_compute_network.vpc_network]

}

resource "google_compute_subnetwork" "public_subnet2" {
  name          = var.subnet2_name
  ip_cidr_range = var.subnet2_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region
  #depends_on = [google_compute_network.vpc_network]

}

resource "google_compute_subnetwork" "private_subnet1" {
  name          = var.subnet3_name
  ip_cidr_range = var.subnet3_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region
  #depends_on = [google_compute_network.vpc_network]

}

resource "google_compute_route" "default_internet_route" {
  name             = var.route_name
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  tags             = ["${var.route_name}"]
}

resource "google_compute_firewall" "allow_internet_egress_public" {
  name    = "allow-egress-internet-public"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
  priority           = 1000
  target_tags        = ["public"]
}

resource "google_compute_firewall" "allow_internet_ingress_public" {
  name    = "allow-ingress-public"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  target_tags   = ["public"]
}

resource "google_compute_firewall" "allow_internal_private" {
  name    = "allow-internal-private"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["10.0.0.0/16"] # Allow only internal traffic within VPC
  priority           = 1000
  target_tags        = ["private"]
}

