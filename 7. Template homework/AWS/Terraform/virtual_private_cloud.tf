#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Virtual Private Cloud
#===========================================================================================

resource "aws_vpc" "Homework_VPC" {
  cidr_block = "10.0.0.0/16"
  # Enabling the DNS support. Without it you will be unable to use the SSM Session Manager
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.VPC
}
