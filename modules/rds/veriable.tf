variable "vpc_name" {
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
