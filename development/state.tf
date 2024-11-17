terraform {
  backend "gcs" {
    bucket      = "hyper-mgmt-terraform-state-us-central1"
    prefix      = "development/hypernova/development.tfstate"
    credentials = "key.json"
  }
}
