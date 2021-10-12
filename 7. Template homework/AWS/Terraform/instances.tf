#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Instances
#===========================================================================================

# Creating EC2 Instances with dynamic userdata and SSM profile
resource "aws_instance" "VPC_EC2_Instance" {
  count = var.Amount_of_Zones * var.EC2_Per_Zone

  ami                    = data.aws_ami.Amazon_Latest.id
  instance_type          = var.Instance_Type
  subnet_id              = aws_subnet.VPC_Private_Subnet[count.index % var.Amount_of_Zones].id
  vpc_security_group_ids = [aws_security_group.VPC_Instances_Security_Group.id]
  iam_instance_profile   = aws_iam_instance_profile.Instances_SSM_Profile.name
  user_data              = local.User_Data

  tags = merge(local.Tags, { Name = "${var.Environment_Tag}-EC2 Instance #${tostring(count.index + 1)} ${local.Availability_zone[count.index % var.Amount_of_Zones]}" })

  lifecycle {
    create_before_destroy = true
  }
}

# Attaching the EC2 Instances to ALB target group
resource "aws_lb_target_group_attachment" "VPC_EC2_Instance_TG" {
  count = var.Amount_of_Zones * var.EC2_Per_Zone

  target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  target_id        = aws_instance.VPC_EC2_Instance[count.index].id
  port             = 80
}
