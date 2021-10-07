#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# Virtual Private Cloud main resources
#----------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "Homework_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name"    = "Rainbow Gravity's VPC"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }
}

resource "aws_internet_gateway" "VPC_Internet_Gateway" {
  vpc_id = aws_vpc.Homework_VPC.id

  tags = {
    "Name"    = "VPC Internet Gateway"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }
}

resource "aws_nat_gateway" "VPC_NAT_A" {
  allocation_id = aws_eip.VPC_NAT_EIP_A.id
  subnet_id     = aws_subnet.VPC_Public_Subnet_A.id

  tags = {
    "Name"    = "VPC NAT A"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }

  depends_on = [aws_internet_gateway.VPC_Internet_Gateway, aws_eip.VPC_NAT_EIP_A]
}

resource "aws_eip" "VPC_NAT_EIP_A" {
  vpc = true
}

resource "aws_nat_gateway" "VPC_NAT_B" {
  allocation_id = aws_eip.VPC_NAT_EIP_B.id
  subnet_id     = aws_subnet.VPC_Public_Subnet_A.id

  tags = {
    "Name"    = "VPC NAT B"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }

  depends_on = [aws_internet_gateway.VPC_Internet_Gateway, aws_eip.VPC_NAT_EIP_B]
}

resource "aws_eip" "VPC_NAT_EIP_B" {
  vpc = true
}
