#===========================================================================================
# Rainbow Gravity's CloudFormation Template homework
# 
# VPC Variables
#===========================================================================================

variable "Region" {
  type    = string
  default = "eu-central-1"
}

variable "Instance_Type" {
  type    = string
  default = "t2.micro"
}

variable "Load_Security_Group_Ports" {
  type    = list(string)
  default = ["80","443"]
}

variable "Instances_Security_Group_Ports" {
  type    = list(string)
  default = ["22","80","443"]
}

locals {
  S3_Bucket_Name = "aws-homework-server-rg-${data.aws_region.Current.name}"
  SSH_Instances_Key = "${var.Tags["Environment"]}-instances-ssh-key"
  SSH_Bastion_Key = "${var.Tags["Environment"]}-bastion-ssh-key"
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

variable "Autoscaling" {
  type = map(number)
  default = {
    max_size         = 2
    min_size         = 2
    desired_capacity = 2
  }
}

variable "Tags" {
  type = map(string)
  default = {
    Owner       = "Rainbow Gravity"
    Project     = "CloudFormation Homework"
    Environment = "Dev"
  }
}

