output "DBClusterEndpoint" {
  description = "The endpoint of the Aurora DB cluster"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}

output "DBClusterReadEndpoint" {
  description = "The read-only endpoint of the Aurora DB cluster"
  value       = aws_rds_cluster.aurora_cluster.reader_endpoint
}
