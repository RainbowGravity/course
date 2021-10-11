#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Locals
#===========================================================================================

# Region and avialability zones
locals {
  Current_region           = data.aws_region.Current.name
  Availability_zone        = data.aws_availability_zones.Available.names
  Availability_zone_lenght = length(data.aws_availability_zones.Available.names)
}

# S3 Bucket name
locals {
  S3_Bucket_Name = "${lower(local.ENV_Tag)}-${var.S3_Bucket_Name}-${local.Current_region}"
}

# User data
locals {
  User_Data = templatefile("templates/web-server.tpl", {
    region = local.Current_region
    bucket = local.S3_Bucket_Name
  })
}

# NAT
locals {
  Enable_NAT = var.Enable_NAT ? var.Amount_of_Zones : 0
}

locals {
  Tags = {
    Environment = var.Environment_Tag
    Project     = var.Project_Tag
    Owner       = var.Owner_Tag
  }
}

# Tags for several resources
locals {
  VPC                      = merge(local.Tags, { Name = "${local.Tags["Environment"]} VPC" })
  Internet_Gateway         = merge(local.Tags, { Name = "${local.Tags["Environment"]}-VPC Internet Gateway" })
  S3_Bucket                = merge(local.Tags, { Name = "${local.ENV_Tag} VPC Server Files" })
  ENV_Tag                  = local.Tags["Environment"]
  ALB_Tags                 = merge(local.Tags, { Name = "VPC Load Balancer" })
  S3_Endpoint              = merge(local.Tags, { Name = "${local.ENV_Tag}-S3 Endpoint" })
  SSM_Endpoint             = merge(local.Tags, { Name = "${local.ENV_Tag}-SSM Endpoint" })
  SSM_Messages             = merge(local.Tags, { Name = "${local.ENV_Tag}-SSM-Messages Endpoint" })
  EC2_Messages             = merge(local.Tags, { Name = "${local.ENV_Tag}-EC2-Messages Endpoint" })
  SSM_Role                 = merge(local.Tags, { Name = "${local.ENV_Tag}InstancesSSMRole" })
  Gateway_Table            = merge(local.Tags, { Name = "${local.ENV_Tag}-VPC Internet Gateway Table" })
  Load_Security_Group      = merge(local.Tags, { Name = "${local.ENV_Tag}-Load Balancer security group" })
  Instances_Security_Group = merge(local.Tags, { Name = "${local.ENV_Tag}-Instances security group" })
  SSM_Security_Group       = merge(local.Tags, { Name = "${local.ENV_Tag}-SSM security group" })
}
