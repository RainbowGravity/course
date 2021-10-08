#===========================================================================================
# Rainbow Gravity's CloudFormation Template homework
# 
# Endpoints
#===========================================================================================

resource "aws_vpc_endpoint" "Endpoint" {
  vpc_id          = aws_vpc.Homework_VPC.id
  route_table_ids = [aws_route_table.VPC_NAT_A_Table.id, aws_route_table.VPC_NAT_B_Table.id]
  service_name    = "com.amazonaws.${data.aws_region.Current.name}.s3"

  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]} VPC Endpoint" })
}
