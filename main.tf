module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.bucket_name
  environment = var.environment
  bucket_name_vpc = var.bucket_name_vpc
}

module "vpc" {
  source = "../../modules/vpc"
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

module "rds" {
  source = "../../modules/rds"
  engine_name              = var.DBEngineName
  major_engine_version     = var.DBEngineVersion
  backup_retention_period = var.DBBackupRetentionPeriod
  preferred_backup_window = var.Backupwindow
  preferred_maintenance_window = var.Maintenancewindow
  database_name           = var.DBName
  identifier              = var.DBInstnaceName
  instance_class          = var.InstanceType
  monitoring_interval     = var.MonitoringInterval
  performance_insights_retention_period = var.PerformanceInsightsRetentionPeriod
  cluster_identifier      = var.DBClusterName
  vpc_name = var.vpc_name
