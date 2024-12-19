
output "gke_cluster_name" {
  description = "The name of the created GKE cluster"
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the created GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "node_pools" {
  description = "The configured node pools for the GKE cluster"
  value       = google_container_node_pool.worker_node_pool
}

