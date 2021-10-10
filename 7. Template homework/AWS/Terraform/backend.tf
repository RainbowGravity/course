#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# Backend 
#----------------------------------------------------------------------

# terraform {
#   backend "s3" {
#     bucket = "aws-homework-rg-eu-central-1"
#     key    = "vpc-state/terraform.tfstate"
#     region = "eu-west-1"
#   }
# }

# resource "aws_s3_bucket" "VPC_State" {
#   bucket = "aws-homework-rg-eu-west-1"
#   acl    = "private"

#   lifecycle {
#     prevent_destroy = true
#   }

#   tags = {
#     "Name"    = "VPC State Bucket"
#     "Owner"   = "Rainbow Gravity"
#     "Project" = "Homework"
#   }
# }
