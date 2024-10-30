locals {
  project_id = "hypernova-439518"
}

module "mgt_compute" {
  source     = "../modules/management-compute"
  project_id = local.project_id

}
