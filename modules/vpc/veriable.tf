variable vpc_cidr {
  type = string
}

variable public_subnet1_cidr {
  type = string
}

variable availability_zone1 {
  type = string
}

variable public_subnet2_cidr {
  type = string
}

variable availability_zone2 {
  type = string
}


variable private_subnet1_cidr {
  type = string
}

variable private_subnet2_cidr {
  type = string
}


variable private_rds_subnet1_cidr {
  type = string
}

variable private_rds_subnet2_cidr {
  type = string
}


variable "region" {
  type = string
}
