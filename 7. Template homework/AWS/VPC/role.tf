#===========================================================================================
# Rainbow Gravity's CloudFormation Template homework
# 
# S3 Read Role
#===========================================================================================


resource "aws_iam_role_policy" "S3_Read_Role_Policy" {
  name = "S3ReadRolePolicy"
  role = aws_iam_role.S3_Read_Role.id

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

resource "aws_iam_role" "S3_Read_Role" {
  name = "S3ReadRole"

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
}

resource "aws_iam_instance_profile" "S3_Read_Instance_Profile" {
  name = "S3ReadInstanceProfile"
  role = aws_iam_role.S3_Read_Role.name
}
