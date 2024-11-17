locals {

  vpc_name          = "vpc-development-hyper-us-central1"
  subnet1_cidr      = "10.20.10.0/24"
  subnet1_name      = "subnet-development-hyper-public-us-central1-z1"
  subnet2_cidr      = "10.20.15.0/24"
  subnet2_name      = "subnet-development-hyper-public-us-central1-z2"
  subnet3_cidr      = "10.20.20.0/24"
  subnet3_name      = "subnet-development-hyper-private-us-central1-z1"
  subnet4_cidr      = "10.20.25.0/24"
  subnet4_name      = "subnet-development-hyper-private-us-central1-z2"
  public_route_name = "rtb-development-hyper-default-public-internet-route-us-central1"
  environment       = "development"
  region            = "us-central1"

}

module "dev_vpc" {
  source            = "../modules/development-vpc"
  vpc_name          = local.vpc_name
  subnet1_cidr      = local.subnet1_cidr
  subnet1_name      = local.subnet1_name
  subnet2_cidr      = local.subnet2_cidr
  subnet2_name      = local.subnet2_name
  subnet3_cidr      = local.subnet3_cidr
  subnet3_name      = local.subnet3_name
  subnet4_cidr      = local.subnet4_cidr
  subnet4_name      = local.subnet4_name
  public_route_name = local.public_route_name
  region            = local.region
}
