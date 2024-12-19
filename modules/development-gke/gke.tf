resource "google_service_account" "gke_sa" {
  account_id   = "gke-sa"
  display_name = "Service Account for GKE"
}

resource "google_project_iam_member" "gke_roles_container_admin" {
  project = var.project_id_gke
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_project_iam_member" "gke_roles_instance_admin" {
  project = var.project_id_gke
  role    = "roles/compute.instanceAdmin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_project_iam_member" "gke_roles_service_account_user" {
  project = var.project_id_gke
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_container_cluster" "gke_cluster" {
  name       = var.cluster_name
  location   = var.location
  network    = var.network
  subnetwork = var.subnetwork
  project    = var.project_id_gke

  deletion_protection      = false
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"

  # Adding tags to the GKE cluster
  resource_labels = {
    environment = "development"
    firewall    = "development-vpc"
  }

  # Adding release channel configuration
  release_channel {
    channel = "STABLE" # Options: "RAPID", "REGULAR", "STABLE"
  }


  ip_allocation_policy {

  }


  private_cluster_config {
    #enable_private_endpoint = true
    enable_private_nodes   = true
    master_ipv4_cidr_block = "10.20.30.0/28" # Adjust CIDR block if needed
  }


}

resource "google_container_node_pool" "worker_node_pool" {
  for_each = var.node_pool_config

  name       = "node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = google_container_cluster.gke_cluster.location
  node_count = each.value.min_count

  node_config {
    machine_type = each.value.machine_type
    preemptible  = false
    disk_size_gb = 30
    image_type   = "COS_CONTAINERD"


    service_account = google_service_account.gke_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]



    # Add target tags
    tags = ["development-vpc"]

    # Add SSH key(s)
    metadata = {
      "ssh-keys" = <<-EOF
      hyper:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVFWmoQ0mb7yrjUY8io2QR2SH7jTgi1HkDa5X4IYiJzjFvy2GHUrPVX3x8DMief1xW51rzmdCzJvVfg7v2/l9zt/8HAqtWxVHBQglr57fss8/9bX9JxHOWTPYw43/QxTBASH60rL7MFUud1hyfqxf/SDq5oR5MqhOgkK/e5EYBIKxxaubJwTK4dbJjG8Ku5KBbDXMb65KZlCtEyzIs5V3RYwOF9VyjromucDKiWyCTmqgv97YCBBqzXjb9dVNP+kMBltlCsBx7tPKDDcrmnZzpVktnjMTRJnnF9rr0iEVZYLuNo0mRxFSc6e+z/f0lfIETjRxGAi1a95kmEGCmw85aRfkMTsF83ZmpUt+pYoNdnEEMNN+pKvVAEiLBw+qXVqQpK0iRFxOPUgTnjodiLtD7W01rRsUlsj6oE7noMYlenYt3Hwm3jM6m9BMLFC8yoaGptqOzQTOT3MEj+/2ptQdWfFy23+BwrVMrSvnHNk48I0IVOZ+hSt7BEgbJyjCcIFk= key-hyper-us-central1
     EOF
    }


  }

  autoscaling {
    min_node_count = each.value.min_count
    max_node_count = each.value.max_count
  }

  management {
    auto_upgrade = each.value.auto_upgrade
  }

  lifecycle {
    ignore_changes = [
      # Specify attributes to ignore
      node_config[0].metadata,
      node_config[0].kubelet_config,
      node_count,
      autoscaling,
    ]
  }

}

