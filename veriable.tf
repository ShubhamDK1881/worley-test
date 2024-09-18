variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}


variable "vpc_cidr" {
  type = string
}

variable "region" {
  default = "ap-south-1"
}

variable "vpc_name" {
  type = string
}

variable public_subnet1_cidr {
  type = string
}

variable public_subnet2_cidr {
  type = string
}

variable availability_zone1 {
  type = string
}

variable availability_zone2 {
  type = string
}

variable private_subnet1_cidr {
  type = string
}

variable private_subnet2_cidr {
  type = string
}

variable private_rds_subnet1_cidr {
 type = string 
}

variable private_rds_subnet2_cidr {
  type = string
}

variable repo_name_ui {
  type = string
}

variable ecs_cluster_name {
  type = string
}

variable "InstanceType" {
  type = string
}

variable "DBEngineVersion" {
  type = string
}

variable "DBClusterName" {
  type = string
}

variable "DBName" {
  type = string
}

variable "DBBackupRetentionPeriod" {
  type = number
}

variable "Backupwindow" {
  type    = string
}

variable "Maintenancewindow" {
  type    = string
}

variable "DBEngineName" {
  type = string
}

variable "DBInstnaceName" {
  type = string
}

variable "MonitoringInterval" {
  type = number
}

variable "PerformanceInsightsRetentionPeriod" {
  type = number
}
