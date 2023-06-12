# ---root/main.tf---
module "networking" {
  source          = "./networking"
  vpc_cidr        = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  public_sn_count = 2
  public_cidrs    = [for i in range(2, 6, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}


module "compute" {
  source              = "./compute"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
  instance_count      = 1
  instance_type       = "t2.micro"
  volume_size         = 8
  key_name            = "keypc"
  public_key_path     = "/Users/payalchavan/.ssh/keypc.pub"
}

module "jenkins_instance" {
  source              = "./jenkins_instance"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
  instance_count      = 1
  instance_type       = "t2.micro"
  volume_size         = 8
  key_name            = "jenkey"
  jen_key_path        = "/Users/payalchavan/.ssh/jenkey.pub"
}