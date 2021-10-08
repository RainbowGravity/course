#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# SSM Bastion Role and S3 Read Role
#----------------------------------------------------------------------

resource "aws_iam_instance_profile" "Bastion_SSM_Profile" {
  name = "${var.Tags["Environment"]}BastionSSMProfile"
  role = aws_iam_role.Bastion_SSM_Role.name
}

resource "aws_iam_role" "Bastion_SSM_Role" {
  name = "${var.Tags["Environment"]}BastionSSMRole"

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
  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}BastionSSMRole" })
}

resource "aws_iam_role_policy" "Bastion_SSM_Policy" {
  name = "${var.Tags["Environment"]}BastionSSMPolicy"
  role = aws_iam_role.Bastion_SSM_Role.id

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          #          "cloudwatch:PutMetricData",
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

resource "aws_iam_instance_profile" "Instance_S3_Read_Profile" {
  name = "${var.Tags["Environment"]}InstanceS3ReadProfile"
  role = aws_iam_role.Instance_S3_Read_Role.name
}

resource "aws_iam_role" "Instance_S3_Read_Role" {
  name = "${var.Tags["Environment"]}S3ReadRole"

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
  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}InstanceS3ReadProfile" })
}

resource "aws_iam_role_policy" "Instance_S3_Read_Policy" {
  name = "${var.Tags["Environment"]}InstanceS3ReadPolicy"
  role = aws_iam_role.Instance_S3_Read_Role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
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






