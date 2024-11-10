output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}

output "public_subnet1_id" {
  value = google_compute_subnetwork.public_subnet1.id
}

output "public_subnet2_id" {
  value = google_compute_subnetwork.public_subnet2.id
}

output "private_subnet1_id" {
  value = google_compute_subnetwork.private_subnet1.id
}


