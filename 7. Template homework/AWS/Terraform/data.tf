#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Data
#===========================================================================================

# Retrieving latest Amazon Linux 2 AMI
data "aws_ami" "Amazon_Latest" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Retrieving list of the available availability zones
data "aws_availability_zones" "Available" {
  state = "available"
}

# Retrieving current region
data "aws_region" "Current" {}
