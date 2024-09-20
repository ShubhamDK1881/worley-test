output "vpc_id" {
  description = "The VPC ID"
  value = aws_vpc.vpc.id
}

output "vpc_arn" {
  description = "The VPC ID"
  value = aws_vpc.vpc.arn
}
