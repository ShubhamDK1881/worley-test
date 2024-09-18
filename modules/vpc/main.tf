resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet1_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.vpc_name}-PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet2_cidr
  availability_zone = var.availability_zone2
  tags = {
    Name = "${var.vpc_name}-PublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet1_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.vpc_name}-PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet2_cidr
  availability_zone = var.availability_zone2
  tags = {
    Name = "${var.vpc_name}-PrivateSubnet2"
  }
}

resource "aws_subnet" "rds_private_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_rds_subnet1_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.vpc_name}-RDS-PrivateSubnet1"
  }
}

resource "aws_subnet" "rds_private_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_rds_subnet2_cidr
  availability_zone = var.availability_zone2
  tags = {
    Name = "${var.vpc_name}-RDS-PrivateSubnet2"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-PublicRouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_subnet1_route_table_association" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_route_table_association" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_subnet1_route_table_association" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_route_table_association" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_vpc_endpoint" "s3-vpc-endpoint" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.s3"  # Use data.aws_region.current.name here
  route_table_ids = [
    aws_route_table.public_route_table.id,
    aws_route_table.private_route_table.id
  ]

  tags = {
    Name = "worley-s3-vpc-endpoint"
  }
}
