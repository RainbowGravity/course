#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Endpoints
#===========================================================================================

resource "aws_vpc_endpoint" "Endpoint" {

  vpc_id          = aws_vpc.Homework_VPC.id
  route_table_ids = [aws_route_table.VPC_NAT_A_Table.id, aws_route_table.VPC_NAT_B_Table.id]
  service_name    = "com.amazonaws.${local.Current_region}.s3"

  tags = merge(var.Tags, { Name = "${local.ENV_Tag}-S3 Endpoint" })
}

resource "aws_vpc_endpoint" "SSM" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.VPC_Private_Subnet_A.id]

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = merge(var.Tags, { Name = "${local.ENV_Tag}-SSM Endpoint" })
}

resource "aws_vpc_endpoint" "SSM_Messages" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.VPC_Private_Subnet_A.id]

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = merge(var.Tags, { Name = "${local.ENV_Tag}-SSM-Messages Endpoint" })
}

resource "aws_vpc_endpoint" "EC2_Messages" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.VPC_Private_Subnet_A.id]

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = merge(var.Tags, { Name = "${local.ENV_Tag}-EC2-Messages Endpoint" })
}
