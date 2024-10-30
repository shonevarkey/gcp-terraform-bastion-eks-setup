terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.4.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "hypernova-439518"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "key.json"
}

resource "google_storage_bucket" "hyperv1" {
  name     = "hypernova-version1"
  location = "us-central1"

}