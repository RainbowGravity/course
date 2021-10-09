#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Variables
#===========================================================================================

variable "Region" {
  type    = string
  default = "eu-central-1"
}


variable "Amount_of_Zones" {
  type    = number
  default = 3
}

variable "EC2_Per_Zone" {
  type    = number
  default = 2
}

variable "Availability_zone_A" {
  type    = number
  default = 0
}

variable "Availability_zone_B" {
  type    = number
  default = 1
}

variable "Instance_Type" {
  type    = string
  default = "t2.micro"
}

variable "Load_Security_Group_Ports" {
  type    = list(string)
  default = ["80"]
}

variable "Instances_Security_Group_Ports" {
  type    = list(string)
  default = ["22", "80"]
}

variable "S3_Bucket_Name" {
  type    = string
  default = "aws-server-files-rg"
}

variable "Monitoring" {
  type    = string
  default = false
}

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

variable "Tags" {
  type = map(string)
  default = {
    Owner       = "Rainbow Gravity"
    Project     = "Template Homework"
    Environment = "Dev"
  }
}

