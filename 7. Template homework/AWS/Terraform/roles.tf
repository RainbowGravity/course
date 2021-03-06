#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# Instances SSM Role
#----------------------------------------------------------------------

# Creating the SSM profile for EC2 Instances
resource "aws_iam_instance_profile" "Instances_SSM_Profile" {
  name = "${var.Environment_Tag}InstancesSSMProfile"

  role = aws_iam_role.Instances_SSM_Role.name
}

# Creating the SSM Role for EC2 Instances 
resource "aws_iam_role" "Instances_SSM_Role" {
  name = "${var.Environment_Tag}InstancesSSMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = local.SSM_Role
}

# Creating the SSM Role Policy for the SSM Role
resource "aws_iam_role_policy" "Instances_SSM_Policy" {
  name = "${var.Environment_Tag}InstancesSSMPolicy"

  role = aws_iam_role.Instances_SSM_Role.id

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "cloudwatch:PutMetricData",
          "ds:CreateComputer",
          "ds:DescribeDirectories",
          "ec2:DescribeInstanceStatus",
          "logs:*",
          "ssm:*",
          "ec2messages:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = "iam:CreateServiceLinkedRole",
        "Resource" = "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*",
        "Condition" = {
          "StringLike" = {
            "iam:AWSServiceName" : "ssm.amazonaws.com"
          }
        }
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "iam:DeleteServiceLinkedRole",
          "iam:GetServiceLinkedRoleDeletionStatus"
        ],
        "Resource" = "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource" = "*"
      },
      {
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}




