terraform {
  backend "gcs" {
    bucket      = "hyper-mgmt-terraform-state-us-central1"
    prefix      = "management/hypernova/management.tfstate"
    credentials = "key.json"
  }
}
