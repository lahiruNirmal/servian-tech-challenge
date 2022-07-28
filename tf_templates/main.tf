# Network module
module "network" {
  source = "./networking"
  region = var.region
}

# Database module
module "db" {
  source               = "./rds"
  db_security_group_id = module.network.db_sg_id
  db_subnet_ids        = [module.network.db_subnet_1_id, module.network.db_subnet_2_id]
}

# Compute module
module "compute" {
  source            = "./compute"
  app_sg_id         = module.network.app_sg_id
  lb_sg_id          = module.network.lb_sg_id
  public_subnet_ids = [module.network.public_subnet_1_id, module.network.public_subnet_2_id]
  app_subnet_ids    = [module.network.app_subnet_1_id, module.network.app_subnet_2_id]
  vpc_id            = module.network.vpc_id
  region            = var.region
  db_secret_name    = var.db_secret_name
  db_secret = {
    db_username = module.rds.db_password
    db_password = module.rds.db_username
    db_endpoint = module.rds.rds_endpoint
    db_port     = module.rds.rds_port
  }

}