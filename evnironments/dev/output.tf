output "vpc_id" {
  description = "The VPC ID"
  value = module.vpc.id
}

output "vpc_arn" {
  description = "The VPC ID"
  value = module.vpc.vpc_arn
}

output "DBClusterEndpoint" {
  description = "The endpoint of the Aurora DB cluster"
  value       = module.rds.DBClusterEndpoint
}

output "DBClusterReadEndpoint" {
  description = "The read-only endpoint of the Aurora DB cluster"
  value       = module.rds.DBClusterReadEndpoint
}
