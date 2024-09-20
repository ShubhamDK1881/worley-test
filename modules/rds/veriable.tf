variable instance_type {
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
}
