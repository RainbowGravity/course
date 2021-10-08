#===========================================================================================
# Rainbow Gravity's CloudFormation Template homework
# 
# Data
#===========================================================================================

data "aws_ami" "Amazon_Latest" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_availability_zones" "Available" {
  state = "available"
}

data "aws_region" "Current" {}
