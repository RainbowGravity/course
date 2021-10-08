#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC Instances
#===========================================================================================

resource "aws_launch_configuration" "VPC_EC2_Configuration" {
  name = "${var.Tags["Environment"]}-VPC EC2 Configuration"

  image_id             = data.aws_ami.Amazon_Latest.id
  instance_type        = var.Instance_Type
  security_groups      = [aws_security_group.VPC_Instances_Security_Group.id]
  iam_instance_profile = aws_iam_instance_profile.Instances_SSM_Profile.name
  enable_monitoring    = var.Monitoring

  user_data = templatefile("templates/web-server.tpl", {
    region = data.aws_region.Current.name
    bucket = local.S3_Bucket_Name
  })
}

resource "aws_autoscaling_group" "VPC_Autoscaling_Group" {
  name = "${var.Tags["Environment"]}-VPC Autoscaling Group"

  launch_configuration = aws_launch_configuration.VPC_EC2_Configuration.id
  max_size             = var.Autoscaling.max_size
  min_size             = var.Autoscaling.min_size
  desired_capacity     = var.Autoscaling.desired_capacity
  capacity_rebalance   = true
  vpc_zone_identifier  = [aws_subnet.VPC_Private_Subnet_A.id, aws_subnet.VPC_Private_Subnet_B.id]
  target_group_arns    = [aws_lb_target_group.VPC_Target_Group.arn]

  lifecycle {
    create_before_destroy = true
  }
  tags = concat(
    [
      {
        key                   = "Name"
        value                 = "${var.Tags["Environment"]}-EC2 Instance-${data.aws_region.Current.name}"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Owner"
        "value"               = var.Tags["Owner"]
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Project"
        "value"               = var.Tags["Project"]
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Environment"
        "value"               = var.Tags["Environment"]
        "propagate_at_launch" = true
      },
    ],
  )
}
