resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet1" {
  name          = var.subnet1_name
  ip_cidr_range = var.subnet1_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region

}

resource "google_compute_subnetwork" "public_subnet2" {
  name          = var.subnet2_name
  ip_cidr_range = var.subnet2_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region

}

resource "google_compute_subnetwork" "private_subnet1" {
  name          = var.subnet3_name
  ip_cidr_range = var.subnet3_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region

}

resource "google_compute_subnetwork" "private_subnet2" {
  name          = var.subnet4_name
  ip_cidr_range = var.subnet4_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region

}

# Cloud Router used for NAT
resource "google_compute_router" "nat_router" {
  name    = "${var.vpc_name}-router"
  network = google_compute_network.vpc_network.id
  region  = var.region
}

# NAT Gateway using the Cloud Router
resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.vpc_name}-nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


# Route for public subnets to access internet via default internet gateway
resource "google_compute_route" "default_internet_route" {
  name             = var.public_route_name
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  tags             = ["${var.public_route_name}"]
}


