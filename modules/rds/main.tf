locals {
  rds_family_map = {
    "10.18" = "aurora-postgresql10"
    "11.9"  = "aurora-postgresql11"
    "12.4"  = "aurora-postgresql12"
    "13.4"  = "aurora-postgresql13"
    "14.3"  = "aurora-postgresql14"
  }
}

resource "aws_db_option_group" "db-option-group" {
  name                     = "aurora-postgresql-15-option-group"
  engine_name              = var.DBEngineName
  major_engine_version     = var.DBEngineVersion
  option_group_description = "Default option group for aurora-postgresql 15"

  }

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = var.DBClusterName
  engine                  = var.DBEngineName
  engine_version          = var.DBEngineVersion
  master_username         = data.aws_secretsmanager_secret_version.db_secret.secret_string["username"]
  master_password         = data.aws_secretsmanager_secret_version.db_secret.secret_string["password"]
  backup_retention_period = var.DBBackupRetentionPeriod
  preferred_backup_window = var.Backupwindow
  preferred_maintenance_window = var.Maintenancewindow
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  storage_encrypted       = true
  database_name           = var.DBName
  rds_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_param_group.name

}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier              = var.DBInstnaceName
  cluster_identifier      = aws_rds_cluster.aurora_cluster.id
  instance_class          = var.InstanceType
  engine                  = var.DBEngineName
  engine_version          = var.DBEngineVersion
  publicly_accessible     = false
  monitoring_interval     = var.MonitoringInterval
  performance_insights_enabled = true
  performance_insights_retention_period = var.PerformanceInsightsRetentionPeriod
  rds_parameter_group_name = aws_rds_parameter_group.rds_param_group.name
  auto_minor_version_upgrade = true
}

resource "aws_rds_cluster_parameter_group" "cluster_param_group" {
  name   = "${var.DBClusterName}-cluster-param-group"
  family = lookup(local.rds_family_map, var.DBEngineVersion)

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  parameter {
    name  = "rds.restrict_password_commands"
    value = "1"
  }
}

resource "aws_rds_cluster_parameter_group" "rds_param_group" {
  name   = "${var.DBClusterName}-param-group"
  family = lookup(local.rds_family_map, var.DBEngineVersion)

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "rds.log_retention_period"
    value = "10080"
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "secretmasterDB" {
   name = "secretmasterDB"
}
  
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = <<EOF
   {
    "username": "worley",
    "password": "${random_password.password.result}"
   }
EOF
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.secretmasterDB.id
}


data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secretmasterDB.arn
}

