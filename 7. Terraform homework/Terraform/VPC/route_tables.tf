#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# VPC Ruote Tables
#----------------------------------------------------------------------

resource "aws_route_table" "VPC_Gateway_Table" {
  vpc_id = aws_vpc.Homework_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC_Internet_Gateway.id
  }

  tags = {
    "Name"    = "VPC Internet Gateway Table"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }
}

resource "aws_route_table_association" "b" {
  gateway_id     = aws_internet_gateway.VPC_Internet_Gateway.id
  route_table_id = aws_route_table.VPC_Gateway_Table.id
}

resource "aws_route_table_association" "VPC_Gateway_Association_A" {
  subnet_id      = aws_subnet.VPC_Public_Subnet_A.id
  route_table_id = aws_route_table.VPC_Gateway_Table.id
}

resource "aws_route_table_association" "VPC_Gateway_Association_B" {
  subnet_id      = aws_subnet.VPC_Public_Subnet_B.id
  route_table_id = aws_route_table.VPC_Gateway_Table.id
}

resource "aws_route_table" "VPC_NAT_A_Table" {
  vpc_id = aws_vpc.Homework_VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.VPC_NAT_A.id
  }

  tags = {
    "Name"    = "VPC NAT A Table"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }
}

resource "aws_route_table_association" "VPC_NAT_Association_A" {
  subnet_id      = aws_subnet.VPC_Private_Subnet_A.id
  route_table_id = aws_route_table.VPC_NAT_A_Table.id
}

resource "aws_route_table" "VPC_NAT_B_Table" {
  vpc_id = aws_vpc.Homework_VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.VPC_NAT_B.id
  }

  tags = {
    "Name"    = "VPC NAT A Table"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Homework"
  }
}

resource "aws_route_table_association" "VPC_NAT_Association_B" {
  subnet_id      = aws_subnet.VPC_Private_Subnet_B.id
  route_table_id = aws_route_table.VPC_NAT_B_Table.id
}
