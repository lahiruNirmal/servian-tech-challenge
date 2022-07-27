module "network" {
  source = "./networking"
}

module "db" {
  source = "./rds"
  db_security_group_id = module.network.db_sg_id
  db_subnet_ids = [module.network.db_subnet_1_id, module.network.db_subnet_2_id]
}

module "compute" {
  source = "./compute"
  db_secret = {
    db_username = module.rds.db_password
    db_password = module.rds.db_username
    db_endpoint  = module.rds.rds_endpoint
    db_port     = module.rds.rds_port
  }
}