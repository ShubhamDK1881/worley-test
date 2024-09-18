output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.bucket_name
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
