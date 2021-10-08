#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Virtual Private Cloud main resources
#===========================================================================================

provider "aws" {
  region = var.Region
}

resource "aws_vpc" "Homework_VPC" {
  cidr_block = "10.0.0.0/16"
  tags       = merge(var.Tags, { Name = "${var.Tags["Environment"]} VPC" })
}

resource "aws_internet_gateway" "VPC_Internet_Gateway" {
  vpc_id = aws_vpc.Homework_VPC.id
  tags   = merge(var.Tags, { Name = "${var.Tags["Environment"]}-VPC Internet Gateway" })
}

# resource "aws_nat_gateway" "VPC_NAT_A" {
#   allocation_id = aws_eip.VPC_NAT_EIP_A.id
#   subnet_id     = aws_subnet.VPC_Public_Subnet_A.id
#   tags          = merge(var.Tags, { Name = "${var.Tags["Environment"]}-VPC NAT A" })

#   depends_on = [aws_internet_gateway.VPC_Internet_Gateway, aws_eip.VPC_NAT_EIP_A]
# }

# resource "aws_eip" "VPC_NAT_EIP_A" {
#   vpc = true
# }

# resource "aws_nat_gateway" "VPC_NAT_B" {
#   allocation_id = aws_eip.VPC_NAT_EIP_B.id
#   subnet_id     = aws_subnet.VPC_Public_Subnet_B.id
#   tags          = merge(var.Tags, { Name = "${var.Tags["Environment"]}-VPC NAT B" })

#   depends_on = [aws_internet_gateway.VPC_Internet_Gateway, aws_eip.VPC_NAT_EIP_B]
# }

# resource "aws_eip" "VPC_NAT_EIP_B" {
#   vpc = true
# }
