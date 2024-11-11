locals {

  vpc_name          = "vpc-management-hyper-us-central1"
  subnet1_cidr      = "10.10.10.0/24"
  subnet1_name      = "subnet-management-hyper-public-us-central1-z1"
  subnet2_cidr      = "10.10.15.0/24"
  subnet2_name      = "subnet-management-hyper-public-us-central1-z2"
  subnet3_cidr      = "10.10.20.0/24"
  subnet3_name      = "subnet-management-hyper-private-us-central1-z1"
  public_route_name = "rtb-management-hyper-default-public-internet-route-us-central1"
  environment       = "management"
  region            = "us-central1"
  zone1             = "us-central1-a"
  zone2             = "us-central1-b"
}

module "mgt_vpc" {
  source            = "../modules/management-vpc"
  vpc_name          = local.vpc_name
  subnet1_cidr      = local.subnet1_cidr
  subnet1_name      = local.subnet1_name
  subnet2_cidr      = local.subnet2_cidr
  subnet2_name      = local.subnet2_name
  subnet3_cidr      = local.subnet3_cidr
  subnet3_name      = local.subnet3_name
  public_route_name = local.public_route_name
  region            = local.region
  zone1             = local.zone1
  zone2             = local.zone2

}
