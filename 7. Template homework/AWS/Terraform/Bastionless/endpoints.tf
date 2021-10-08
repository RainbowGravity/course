#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Endpoints
#===========================================================================================

resource "aws_vpc_endpoint" "Endpoint" {

  vpc_id          = aws_vpc.Homework_VPC.id
  route_table_ids = [aws_route_table.VPC_NAT_A_Table.id, aws_route_table.VPC_NAT_B_Table.id]
  service_name    = "com.amazonaws.${data.aws_region.Current.name}.s3"

  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-S3 Endpoint" })
}

resource "aws_vpc_endpoint" "SSM" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${data.aws_region.Current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.VPC_Private_Subnet_A.id]

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-SSM Endpoint" })
}

resource "aws_vpc_endpoint" "SSM_Messages" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${data.aws_region.Current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.VPC_Private_Subnet_A.id]

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-SSM-Messages Endpoint" })
}

resource "aws_vpc_endpoint" "EC2_Messages" {
  vpc_id            = aws_vpc.Homework_VPC.id
  service_name      = "com.amazonaws.${data.aws_region.Current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.VPC_Private_Subnet_A.id]

  security_group_ids = [
    aws_security_group.VPC_SSM_Security_Group.id,
  ]

  private_dns_enabled = true

  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-EC2-Messages Endpoint" })
}
