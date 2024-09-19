module "vpc" {
  source = "./modules/vpc"
  region = var.region
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
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
  source = "./modules/rds"
  DBClusterName = var.DBClusterName
  DBEngineVersion     = var.DBEngineVersion
  DBBackupRetentionPeriod = var.DBBackupRetentionPeriod
  Backupwindow = var.Backupwindow
  Maintenancewindow = var.Maintenancewindow
  DBName = var.DBName
  DBInstnaceName = var.DBInstnaceName
  InstanceType          = var.InstanceType
  MonitoringInterval     = var.MonitoringInterval
  PerformanceInsightsRetentionPeriod = var.PerformanceInsightsRetentionPeriod
  DBEngineName = var.DBEngineName
  vpc_name = var.vpc_name
}
