#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Gateways
#===========================================================================================

# Creating the Internet Gateway for VPC
resource "aws_internet_gateway" "VPC_Internet_Gateway" {
  vpc_id = aws_vpc.Homework_VPC.id
  tags   = local.Internet_Gateway
}

# Creating the NAT gateways for each availability zone if set to true
resource "aws_nat_gateway" "VPC_NAT" {
  count = local.Enable_NAT

  allocation_id = aws_eip.VPC_NAT_EIP[count.index].id
  subnet_id     = aws_subnet.VPC_Public_Subnet[count.index].id
  tags          = merge(local.Tags, { Name = "${local.ENV_Tag}-NAT ${local.Availability_zone[count.index]}" })

  depends_on = [aws_internet_gateway.VPC_Internet_Gateway, aws_eip.VPC_NAT_EIP]
}

# Creating eIPs for NATs
resource "aws_eip" "VPC_NAT_EIP" {
  count = local.Enable_NAT
  vpc   = true
}
