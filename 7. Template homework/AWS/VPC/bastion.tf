#===========================================================================================
# Rainbow Gravity's CloudFormation Template homework
# 
# VPC Bastion 
#===========================================================================================

resource "aws_launch_configuration" "VPC_EC2_Bastion" {
  name_prefix = "${var.Tags["Environment"]}-"
  
  key_name             = aws_key_pair.SSH_Public_Bastion_Key.key_name
  image_id             = data.aws_ami.Amazon_Latest.id
  instance_type        = var.Instance_Type
  security_groups      = [aws_security_group.VPC_Bastion_Security_Group.id]
  enable_monitoring    = var.Monitoring

#   user_data = << EOF
# #!/bin/bash
# echo '${tls_private_key.SSH_Private_Bastion_Key.private_key_pem}' > ~/.ssh/${local.SSH_Bastion_Key}.pem; chmod 400 ~/.ssh/${local.SSH_Bastion_Key}.pem
# EOF
}

resource "aws_autoscaling_group" "VPC_Bastion_Group" {
  name_prefix = "${var.Tags["Environment"]}-"

  launch_configuration = aws_launch_configuration.VPC_EC2_Bastion.id
  desired_capacity          = "1"
  min_size                  = "1"
  max_size                  = "1"
  health_check_grace_period = "60"
  health_check_type         = "EC2"
  force_delete              = false
  wait_for_capacity_timeout = 0
  vpc_zone_identifier = [aws_subnet.VPC_Public_Subnet_A.id, aws_subnet.VPC_Public_Subnet_B.id]

  lifecycle {
    create_before_destroy = true
  }
  tags = concat(
    [
      {
        key                   = "Name"
        value                 = "${var.Tags["Environment"]}-${data.aws_region.Current.name}-Bastion Instance"
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