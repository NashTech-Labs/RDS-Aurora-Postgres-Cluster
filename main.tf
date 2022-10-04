# Virtual Private Cloud Module
module "vpc_module" {
  source       = "./vpc_module"
  cluster_name = var.cluster_name
  env          = var.env
}


module "rds_module" {
  source           = "./rds_module"
  
  env              = var.env
  db-name          = "develop"
  db-username      = var.db_username
  db-password      = var.db_password
  
  vpc_id           = module.vpc_module.vpc_id
  cidr             = module.vpc_module.cidr
  
  public-subnet-1  = module.vpc_module.public-subnet-1
  public-subnet-2  = module.vpc_module.public-subnet-2
}
