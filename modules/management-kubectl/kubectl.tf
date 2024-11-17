resource "google_service_account" "kubectl_sa" {
  account_id   = "kubectl-sa"
  display_name = "Service Account for Kubectl"
}

resource "google_project_iam_member" "kubectl_roles_container_admin" {
  project = var.project_id_kubectl
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.kubectl_sa.email}"
}

resource "google_project_iam_member" "kubectl_roles_network_viewer" {
  project = var.project_id_kubectl
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${google_service_account.kubectl_sa.email}"
}

resource "google_project_iam_member" "kubectl_roles_instance_admin" {
  project = var.project_id_kubectl
  role    = "roles/compute.instanceAdmin"
  member  = "serviceAccount:${google_service_account.kubectl_sa.email}"
}

resource "google_compute_instance" "kubectl" {
  name         = var.kubectl_name
  machine_type = var.kubectl_instancetype
  zone         = var.zone_kubectl

  boot_disk {
    initialize_params {
      image = var.kubectl_image
      size  = var.kubectl_volumesize
      labels = {
        my_label = "hyper-management-kubectl-disk"
      }
    }
  }

  network_interface {
    subnetwork = var.kubectl_subnet
  }

  metadata = {
    "ssh-keys" = <<-EOF
      shone:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzVFNfhayG4F8R1ZXM5/J+Taoq5RuWaOr2vGqUAEmPdphVj3GyxBymjoOs5foHQLldVXgt2XLDBHxJ7TDnrccLcM9L4BVgBZBzQ8Ngv7fYfcWLw6eQgkqdXrnNZ9l3EHa+jjEAsbbNfJCtF32uaf+txiZpaoS18PoBfKfl6P9kTlCofPkRqPIM+KJ2OfmDd0QG+HY7GUdGoRnurimcHaxNjSnGFEmxWHFtOrs3Mv7a4DxVueeYoTwI9rbX2k2Ny3WrMinxqpqSvXFv5F/t1ogSqtqwfLFqpUaoDyU/UdrNRjt2MN/D4v4Hw1dOSWoWtz7ygA+KM9Hb7zo6V1NK0NCeYTglDit3BIR/71cE91jLmstPFAY6K5gfQ6OVNSQaJsQFUdgmW9qvAG1nFDG9lHbIrGFvrcw0KgIGxk2cWllihrFDRZw8qbWAZZCEHk0tb7kzQkt7kEJbyQFb3vkBw0yssaIR+7la21J+LFGUKw3NCoHPtS1xomVDlSM+UI7tg9U= shone
      ${var.kubectl_user}:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVFWmoQ0mb7yrjUY8io2QR2SH7jTgi1HkDa5X4IYiJzjFvy2GHUrPVX3x8DMief1xW51rzmdCzJvVfg7v2/l9zt/8HAqtWxVHBQglr57fss8/9bX9JxHOWTPYw43/QxTBASH60rL7MFUud1hyfqxf/SDq5oR5MqhOgkK/e5EYBIKxxaubJwTK4dbJjG8Ku5KBbDXMb65KZlCtEyzIs5V3RYwOF9VyjromucDKiWyCTmqgv97YCBBqzXjb9dVNP+kMBltlCsBx7tPKDDcrmnZzpVktnjMTRJnnF9rr0iEVZYLuNo0mRxFSc6e+z/f0lfIETjRxGAi1a95kmEGCmw85aRfkMTsF83ZmpUt+pYoNdnEEMNN+pKvVAEiLBw+qXVqQpK0iRFxOPUgTnjodiLtD7W01rRsUlsj6oE7noMYlenYt3Hwm3jM6m9BMLFC8yoaGptqOzQTOT3MEj+/2ptQdWfFy23+BwrVMrSvnHNk48I0IVOZ+hSt7BEgbJyjCcIFk= key-hyper-us-central1
     EOF

    # Metadata startup script to install updates and network tools
    startup-script = <<-EOF
        #!/bin/bash

        # Update package list and install prerequisites
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

        # Download the Google Cloud public signing key
        sudo mkdir -p -m 755 /etc/apt/keyrings
        curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
        sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg 

        # Add the Kubernetes apt repository
        echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
        sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list 

        # Update the package list again
        sudo apt-get update

        # Install kubectl
        sudo apt-get install -y kubectl

        # Verify kubectl installation
        kubectl version --client


        # Install net-tools package
        sudo apt-get install -y net-tools
    EOF
  }

  service_account {
    email  = google_service_account.kubectl_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["kubectl"]
}
