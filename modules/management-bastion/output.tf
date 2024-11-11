output "bastion_id" {
  value = google_compute_instance.bastion.id
}

output "bastion_privateip" {
  value = google_compute_instance.bastion.network_interface[0].network_ip
}

output "public_ip" {
  value = google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip
}

output "zone1" {
  value = google_compute_instance.bastion.zone
}
