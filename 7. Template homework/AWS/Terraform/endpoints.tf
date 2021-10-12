#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Endpoints
#===========================================================================================

# Creating endpoint for S3 Bucket service
resource "aws_vpc_endpoint" "S3_Endpoint" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.VPC_Private_Subnet_Table.*.id

  tags = local.S3_Endpoint
}

# Creating endpoint for SSM service
resource "aws_vpc_endpoint" "SSM_Endpoint" {
  vpc_id              = aws_vpc.Homework_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  tags = local.SSM_Endpoint
}

# Creating endpoint for SSM Messages service
resource "aws_vpc_endpoint" "SSM_Messages_Endpoint" {
  vpc_id              = aws_vpc.Homework_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  tags = local.SSM_Messages
}

# Creating endpoint for EC2 Messages service
resource "aws_vpc_endpoint" "EC2_Messages_Endpoint" {
  vpc_id              = aws_vpc.Homework_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  tags = local.EC2_Messages
}
