output "vpc_id" {
  description = "The VPC ID"
  value = module.vpc.id
}

output "vpc_arn" {
  description = "The VPC ID"
  value = module.vpc.arn
}
