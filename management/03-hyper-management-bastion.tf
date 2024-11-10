locals {
  bastion_name         = "bastion-management-hyper"
  bastion_user         = "hyper"
  bastion_volumesize   = "10"
  bastion_image        = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240830"
  bastion_instancetype = "e2-medium"
  zone3                = "us-central1-a"
  project_id1          = "hypernova-439518"
}

module "mgt_bastion" {
  source               = "../modules/management-bastion"
  vpc_id               = module.mgt_vpc.vpc_network_id
  bastion_subnet       = module.mgt_vpc.public_subnet1_id
  bastion_firewall_id  = google_compute_firewall.allow_bastion_ingress.id
  bastion_name         = local.bastion_name
  bastion_user         = local.bastion_user
  bastion_volumesize   = local.bastion_volumesize
  bastion_image        = local.bastion_image
  bastion_instancetype = local.bastion_instancetype
  zone3                = local.zone3
  project_id1          = local.project_id1
}
