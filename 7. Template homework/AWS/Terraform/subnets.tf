#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Subnets
#===========================================================================================

resource "aws_subnet" "VPC_Public_Subnet" {
  count = var.Amount_of_Zones

  vpc_id                  = aws_vpc.Homework_VPC.id
  cidr_block              = "10.0.1${tostring(count.index + 1)}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = local.Availability_zone[count.index]
  tags                    = merge(var.Tags, { Name = "${local.ENV_Tag}-Public Subnet ${local.Availability_zone[count.index]}" })
}
resource "aws_subnet" "VPC_Private_Subnet" {
  count = var.Amount_of_Zones

  vpc_id            = aws_vpc.Homework_VPC.id
  cidr_block        = "10.0.2${tostring(count.index + 1)}.0/24"
  availability_zone = local.Availability_zone[count.index]
  tags              = merge(var.Tags, { Name = "${local.ENV_Tag}-Private Subnet ${local.Availability_zone[count.index]}" })
}

