provider "aws" {
  region = "sa-east-1"
}

module "network" {
  source = "./modules/network/"

}

module "compute" {
  source         = "./modules/compute"
  subnet_id      = module.network.subnet_id
  website_sg_id  = module.network.website_sg_id
  mlserver_sg_id = module.network.mlserver_sg_id
}
