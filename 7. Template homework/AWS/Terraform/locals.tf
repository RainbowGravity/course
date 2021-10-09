#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Locals
#===========================================================================================



locals {
  Current_region    = data.aws_region.Current.name
  Availability_zone = data.aws_availability_zones.Available.names
}


locals {
  S3_Bucket_Name = "${var.S3_Bucket_Name}-${local.Current_region}"
}

locals {
  User_Data = templatefile("templates/web-server.tpl", {
    region = local.Current_region
    bucket = local.S3_Bucket_Name
  })
}

locals {
  description              = "Tags"
  VPC                      = merge(var.Tags, { Name = "${var.Tags["Environment"]} VPC" })
  Internet_Gateway         = merge(var.Tags, { Name = "${var.Tags["Environment"]}-VPC Internet Gateway" })
  NAT_A                    = merge(var.Tags, { Name = "${var.Tags["Environment"]}-VPC NAT A" })
  NAT_B                    = merge(var.Tags, { Name = "${var.Tags["Environment"]}-VPC NAT B" })
  S3_Bucket                = merge(var.Tags, { Name = "${local.ENV_Tag} VPC Server Files" })
  ENV_Tag                  = var.Tags["Environment"]
  ALB_Tags                 = merge(var.Tags, { Name = "VPC Load Balancer" })
  S3_Endpoint              = merge(var.Tags, { Name = "${local.ENV_Tag}-S3 Endpoint" })
  SSM_Endpoint             = merge(var.Tags, { Name = "${local.ENV_Tag}-SSM Endpoint" })
  SSM_Messages             = merge(var.Tags, { Name = "${local.ENV_Tag}-SSM-Messages Endpoint" })
  EC2_Messages             = merge(var.Tags, { Name = "${local.ENV_Tag}-EC2-Messages Endpoint" })
  VPC_EC2_A                = merge(var.Tags, { Name = "${local.ENV_Tag}-EC2 Instance A" })
  VPC_EC2_B                = merge(var.Tags, { Name = "${local.ENV_Tag}-EC2 Instance B" })
  SSM_Role                 = merge(var.Tags, { Name = "${local.ENV_Tag}InstancesSSMRole" })
  Gateway_Table            = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Internet Gateway Table" })
  NAT_A_Table              = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC NAT A Table" })
  NAT_B_Table              = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC NAT B Table" })
  Load_Security_Group      = merge(var.Tags, { Name = "${local.ENV_Tag}-Load Balancer security group" })
  Instances_Security_Group = merge(var.Tags, { Name = "${local.ENV_Tag}-Instances security group" })
  SSM_Security_Group       = merge(var.Tags, { Name = "${local.ENV_Tag}-SSM security group" })
  Public_Subnet_A          = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Public Subnet A" })
  Public_Subnet_B          = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Public Subnet B" })
  Private_Subnet_A         = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Private Subnet A" })
  Private_Subnet_B         = merge(var.Tags, { Name = "${local.ENV_Tag}-VPC Private Subnet B" })
}
