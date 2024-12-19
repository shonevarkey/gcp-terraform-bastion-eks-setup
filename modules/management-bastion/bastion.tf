resource "google_service_account" "bastion_sa" {
  account_id   = "bastion-sa"
  display_name = "Service Account for Bastion"
}

resource "google_project_iam_member" "bastion_roles_instance_admin" {
  project = var.project_id1
  role    = "roles/compute.instanceAdmin"
  member  = "serviceAccount:${google_service_account.bastion_sa.email}"
}

resource "google_project_iam_member" "bastion_roles_service_account_user" {
  project = var.project_id1
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.bastion_sa.email}"
}

resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  machine_type = var.bastion_instancetype
  zone         = var.zone3

  boot_disk {
    initialize_params {
      image = var.bastion_image
      size  = var.bastion_volumesize
      labels = {
        my_label = "hyper-management-bastion-disk"
      }
    }
  }

  network_interface {
    subnetwork = var.bastion_subnet
    access_config {
      nat_ip = google_compute_address.bastion_external_ip.address
    }
  }

  metadata = {
    "ssh-keys" = <<-EOF
      ${var.bastion_user}:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVFWmoQ0mb7yrjUY8io2QR2SH7jTgi1HkDa5X4IYiJzjFvy2GHUrPVX3x8DMief1xW51rzmdCzJvVfg7v2/l9zt/8HAqtWxVHBQglr57fss8/9bX9JxHOWTPYw43/QxTBASH60rL7MFUud1hyfqxf/SDq5oR5MqhOgkK/e5EYBIKxxaubJwTK4dbJjG8Ku5KBbDXMb65KZlCtEyzIs5V3RYwOF9VyjromucDKiWyCTmqgv97YCBBqzXjb9dVNP+kMBltlCsBx7tPKDDcrmnZzpVktnjMTRJnnF9rr0iEVZYLuNo0mRxFSc6e+z/f0lfIETjRxGAi1a95kmEGCmw85aRfkMTsF83ZmpUt+pYoNdnEEMNN+pKvVAEiLBw+qXVqQpK0iRFxOPUgTnjodiLtD7W01rRsUlsj6oE7noMYlenYt3Hwm3jM6m9BMLFC8yoaGptqOzQTOT3MEj+/2ptQdWfFy23+BwrVMrSvnHNk48I0IVOZ+hSt7BEgbJyjCcIFk= key-hyper-us-central1
     EOF

    # Metadata startup script to install updates and network tools
    startup-script = <<-EOF
      #!/bin/bash
      # Update package list and install updates
      sudo apt-get update -y
      sudo apt-get upgrade -y

      # Install net-tools package
      sudo apt-get install -y net-tools
    EOF
  }

  service_account {
    email  = google_service_account.bastion_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["management-bastion", "bastion"]
}

resource "google_compute_address" "bastion_external_ip" {
  name = "bastion-external-ip"
}
