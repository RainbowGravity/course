#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# Data
#----------------------------------------------------------------------

data "aws_ami" "Ubuntu_Latest" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_availability_zones" "Available" {
  state = "available"
}

output "Available_zone" {
  value = data.aws_availability_zones.Available.names
}
