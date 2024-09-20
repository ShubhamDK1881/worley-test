locals {
  db_family_map = {
    "10.18" = "aurora-postgresql10"
    "11.9"  = "aurora-postgresql11"
    "12.4"  = "aurora-postgresql12"
    "13.4"  = "aurora-postgresql13"
    "14.3"  = "aurora-postgresql14"
  }
}

resource "aws_rds_cluster_parameter_group" "aurora_pg_cluster_pg" {
  name        = "${var.db_cluster_name}-cluster-pg"
  family      = local.db_family_map[var.db_engine_version]
  description = "Cluster Parameter Group For Aurora PostgreSQL Cluster - ${var.db_cluster_name}"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  parameter {
    name  = "rds.restrict_password_commands"
    value = "1"
  }
}


resource "aws_rds_parameter_group" "aurora_pg_pg" {
  name        = "${var.db_cluster_name}-pg"
  family      = local.db_family_map[var.db_engine_version]
  description = "Parameter Group For Aurora PostgreSQL Cluster - ${var.db_cluster_name}"

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

resource "aws_db_subnet_group" "aurora_pg_subnet_group" {
  name       = "aurora-pg-subnet-group"
  subnet_ids = [data.aws_subnet.private1.id, data.aws_subnet.private2.id]

  description = "Subnet group for Aurora DB cluster"
}



resource "aws_security_group" "aurora_pg_sg" {
  name        = "aurora_pg_sg"
  description = "Allow inbound traffic to Aurora"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Creating a AWS secret for database 

resource "aws_secretsmanager_secret" "secretmasterDB" {
   name = var.db_secret
}

# Creating a AWS secret versions for database

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = <<EOF
   {
    "username": "worley",
    "password": "${random_password.password.result}"
   }
EOF
}


# Retrieve the latest version of the secret from Secrets Manager
data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.secretmasterDB.id
}


# Importing the AWS secret version created previously using arn.

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secretmasterDB.arn
}

resource "aws_rds_cluster" "aurora_pg_cluster" {
  engine                    = "aurora-postgresql"
  engine_version            = var.db_engine_version
  cluster_identifier        = var.db_cluster_name
  master_username           = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["username"]
  master_password           = jsondecode(data.aws_secretsmanager_secret.db_secret.secret_string)["password"]
  db_subnet_group_name      = aws_db_subnet_group.aurora_pg_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.aurora_pg_sg.id]
  backup_retention_period   = var.db_backup_retention_period
  preferred_backup_window   = var.backup_window
  preferred_maintenance_window = var.maintenance_window
  storage_encrypted         = true
  database_name             = var.db_name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_pg_cluster_pg.name
}

resource "aws_rds_cluster_instance" "aurora_pg_instance" {
  identifier              = var.db_instance_name
  cluster_identifier      = aws_rds_cluster.aurora_pg_cluster.id
  instance_class          = var.instance_type
  engine                  = "aurora-postgresql"
  engine_version          = var.db_engine_version
  monitoring_interval     = var.monitoring_interval
  auto_minor_version_upgrade = true
  performance_insights_enabled = true
  performance_insights_retention_period = var.performance_insights_retention_period
  publicly_accessible     = false
}
