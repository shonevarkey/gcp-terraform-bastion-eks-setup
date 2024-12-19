
locals {
  cluster_name   = "hyper-dev-cluster-us-central1"
  location       = "us-central1-a"
  project_id_gke = "hypernova-439518"
}

module "dev_gke" {
  source         = "../modules/development-eks"
  network        = module.dev_vpc.vpc_network_id
  subnetwork     = module.dev_vpc.private_subnet2_id
  cluster_name   = local.cluster_name
  location       = local.location
  project_id_gke = local.project_id_gke
  node_pool_config = {
    worker_pool = {
      machine_type = "e2-medium"
      min_count    = 1
      max_count    = 2
      auto_upgrade = true
    }
  }
}


