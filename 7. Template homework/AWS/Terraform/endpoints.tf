#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Endpoints
#===========================================================================================

resource "aws_vpc_endpoint" "Endpoint" {

  vpc_id          = aws_vpc.Homework_VPC.id
  route_table_ids = [aws_route_table.VPC_NAT_Table.id]
  service_name    = "com.amazonaws.${local.Current_region}.s3"

  tags = local.S3_Endpoint
}

resource "aws_vpc_endpoint" "SSM" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.VPC_Private_Subnet.*.id

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = local.SSM_Endpoint
}

resource "aws_vpc_endpoint" "SSM_Messages" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.VPC_Private_Subnet.*.id

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = local.SSM_Messages
}

resource "aws_vpc_endpoint" "EC2_Messages" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.VPC_Private_Subnet.*.id

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = local.EC2_Messages
}
