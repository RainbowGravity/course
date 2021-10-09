#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Locals
#===========================================================================================

locals {
  Current_region      = data.aws_region.Current.name
  Availability_zone_A = data.aws_availability_zones.Available.names[0]
  Availability_zone_B = data.aws_availability_zones.Available.names[1]
  ENV_Tag             = var.Tags["Environment"]
  ALB_Tags            = merge(var.Tags, { Name = "VPC Load Balancer" })

}
