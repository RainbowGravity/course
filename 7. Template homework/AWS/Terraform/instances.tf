#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Instances
#===========================================================================================

resource "aws_instance" "VPC_EC2_Instance_A" {
  ami                    = data.aws_ami.Amazon_Latest.id
  instance_type          = var.Instance_Type
  subnet_id              = aws_subnet.VPC_Private_Subnet_A.id
  vpc_security_group_ids = [aws_security_group.VPC_Instances_Security_Group.id]
  iam_instance_profile   = aws_iam_instance_profile.Instances_SSM_Profile.name

  user_data = templatefile("templates/web-server.tpl", {
    region = local.Current_region
    bucket = local.S3_Bucket_Name
  })
  tags = merge(var.Tags, { Name = "${local.ENV_Tag}-EC2 Instance A" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "VPC_EC2_Instance_A_TG" {
  target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  target_id        = aws_instance.VPC_EC2_Instance_A.id
  port             = 80
}

resource "aws_instance" "VPC_EC2_Instance_B" {
  ami                    = data.aws_ami.Amazon_Latest.id
  instance_type          = var.Instance_Type
  subnet_id              = aws_subnet.VPC_Private_Subnet_B.id
  vpc_security_group_ids = [aws_security_group.VPC_Instances_Security_Group.id]
  iam_instance_profile   = aws_iam_instance_profile.Instances_SSM_Profile.name

  user_data = templatefile("templates/web-server.tpl", {
    region = local.Current_region
    bucket = local.S3_Bucket_Name
  })

  tags = merge(var.Tags, { Name = "${local.ENV_Tag}-EC2 Instance B" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "VPC_EC2_Instance_B_TG" {
  target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  target_id        = aws_instance.VPC_EC2_Instance_B.id
  port             = 80
}
