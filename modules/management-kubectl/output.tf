output "kubectl_id" {
  value = google_compute_instance.kubectl.id
}

output "kubectl_privateip" {
  value = google_compute_instance.kubectl.network_interface[0].network_ip
}

output "zone_kubectl" {
  value = google_compute_instance.kubectl.zone
}
