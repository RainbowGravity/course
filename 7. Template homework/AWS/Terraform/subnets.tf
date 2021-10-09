#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Subnets
#===========================================================================================

resource "aws_subnet" "VPC_Public_Subnet_A" {
  vpc_id                  = aws_vpc.Homework_VPC.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = true
  availability_zone       = local.Availability_zone_A
  tags                    = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Public Subnet A" })
}

resource "aws_subnet" "VPC_Public_Subnet_B" {
  vpc_id                  = aws_vpc.Homework_VPC.id
  cidr_block              = "10.0.21.0/24"
  map_public_ip_on_launch = true
  availability_zone       = local.Availability_zone_B
  tags                    = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Public Subnet B" })
}

resource "aws_subnet" "VPC_Private_Subnet_A" {
  vpc_id            = aws_vpc.Homework_VPC.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = local.Availability_zone_A
  tags              = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Private Subnet A" })
}

resource "aws_subnet" "VPC_Private_Subnet_B" {
  vpc_id            = aws_vpc.Homework_VPC.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = local.Availability_zone_B
  tags              = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Private Subnet B" })
}

