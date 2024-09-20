variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

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

variable internet_gateway_name {
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

variable bucket_name_vpc {
  type = string
}

variable repo_name_ui {
  type = string
}

variable ecs_cluster_name {
  type = string
}

/*variable instance_type {
  type = string
}

variable db_instance_name {
  type = string
}

variable db_engine_version {
  type = string
}

variable db_cluster_name {
  type = string
}

variable db_name {
  type = string
}

variable db_backup_retention_period {
  type = string
}

variable backup_window {
  type = string
  default = "00:00-01:00"
}

variable maintenance_window{
  type = string
  default = "Mon:02:00-Mon:03:00"
}

variable db_engine_name {
  type = string
}

variable db_instnace_name {
  type = string
}

variable monitoring_interval {
  type = string
}

variable performance_insights_retention_period {
  type = string
}

variable db_secret{
    type = string
}*/

variable name {
  type = string
}
