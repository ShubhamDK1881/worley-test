output "vpc_id" {
  description = "The VPC ID"
  value = aws_vpc.vpc.id
}

output "vpc_arn" {
  description = "The VPC ID"
  value = aws_vpc.vpc.arn
}

output "private_subnet1_id" {
  description = "The VPC ID"
  value = aws_vpc.vpc.private_subnet1.id
}

output "private_subnet2_id" {
  description = "The VPC ID"
  value = aws_vpc.vpc.private_subnet2.id
}
