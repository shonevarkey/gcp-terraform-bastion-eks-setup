locals {
  kubectl_name         = "kubectl-management-hyper"
  kubectl_user         = "kubectl"
  kubectl_volumesize   = "10"
  kubectl_image        = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240830"
  kubectl_instancetype = "e2-medium"
  zone_kubectl         = "us-central1-b"
  project_id_kubectl   = "hypernova-439518"
}

module "mgt_kubectl" {
  source               = "../modules/management-kubectl"
  vpc_id               = module.mgt_vpc.vpc_network_id
  kubectl_subnet       = module.mgt_vpc.private_subnet1_id
  kubectl_name         = local.kubectl_name
  kubectl_user         = local.kubectl_user
  kubectl_volumesize   = local.kubectl_volumesize
  kubectl_image        = local.kubectl_image
  kubectl_instancetype = local.kubectl_instancetype
  zone_kubectl         = local.zone_kubectl
  project_id_kubectl   = local.project_id_kubectl
}
