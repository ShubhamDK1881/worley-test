module "vpc" {
  source = "./modules/vpc"
  name = var.name
  region = var.region
  log_destination = module.s3.bucket_name_vpc_arn
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  internet_gateway_name = var.internet_gateway_name
  public_subnet1_cidr = var.public_subnet1_cidr
  public_subnet2_cidr = var.public_subnet2_cidr
  private_subnet1_cidr = var.private_subnet1_cidr
  private_subnet2_cidr = var.private_subnet2_cidr
  private_rds_subnet1_cidr = var.private_rds_subnet1_cidr
  private_rds_subnet2_cidr = var.private_rds_subnet2_cidr
  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
}


/*module "rds" {
  source = "./modules/rds"
  db_name = var.db_name
  db_secret = var.db_secret
  db_cluster_name = var.db_cluster_name
  db_engine_name = var.db_engine_name
  db_engine_version = var.db_engine_version
  db_instance_name = var.db_instance_name
  db_backup_retention_period = var.db_backup_retention_period
  instance_type = var.instance_type
  db_instnace_name = var.db_instance_name
  performance_insights_retention_period = var.performance_insights_retention_period
  monitoring_interval = var.monitoring_interval
}*/
