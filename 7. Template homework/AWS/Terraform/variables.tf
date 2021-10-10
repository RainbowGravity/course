#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Variables
#===========================================================================================

# Default tags. You can add or change them. Maximum lenght of the Environment tag is 5, because it used as name prefix for several resources. Don't delete it.
variable "Tags" {
  type = map(string)
  default = {
    Owner       = "Rainbow Gravity"
    Project     = "Template Homework"
    Environment = "Dev"
  }
}

# Region selection
variable "Region" {
  type    = string
  default = "eu-central-1"
}

# EC2 Instance type
variable "Instance_Type" {
  type    = string
  default = "t2.micro"
}

# Amount of EC2 Instances per avialability zone
variable "EC2_Per_Zone" {
  type    = number
  default = 1
}

# Amount of avialability zones. Cannot be less than 2 or ALB will not start.
variable "Amount_of_Zones" {
  type    = number
  default = 2

  validation {
    condition     = var.Amount_of_Zones >= 2
    error_message = "Amount of avialability zones cannot be less than 2. ALB will not start."
  }
}

# Enable or disable NAT Gateway for your instances. If true, then NAT Gateway will be created for each avialability zone
variable "Enable_NAT" {
  type    = bool
  default = false
}

# Application Load Balancer Security Group ports
variable "Load_Security_Group_Ports" {
  type    = list(string)
  default = ["80"]
}

# Instances Security Group ports
variable "Instances_Security_Group_Ports" {
  type    = list(string)
  default = ["22", "80"]
}

# Name of the S3 Bucket. Region name will be added to the end of the S3 Bucket name. You can see it in locals.tf
variable "S3_Bucket_Name" {
  type    = string
  default = "aws-server-files-rg"
}

# Monitoring of the EC2 Instances
variable "Monitoring" {
  type    = bool
  default = true
}

# ALB Health Check parameters
variable "Health_Check" {
  type = map(number)
  default = {
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = 200
  }
}
