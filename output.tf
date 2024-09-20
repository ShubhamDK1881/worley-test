output "vpc_arn" {
  description = "The VPC ID"
  value = module.vpc.vpc_arn
}

output "DBClusterReadEndpoint" {
  description = "The read-only endpoint of the Aurora DB cluster"
  value       = module.rds.DBClusterReadEndpoint
}

output "vpc_id" {
  description = "The VPC ID"
  value = module.vpc.vpc.id
}
