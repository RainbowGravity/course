#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC CloudWatch Alarm & Auto Recovery
#===========================================================================================

resource "aws_cloudwatch_metric_alarm" "VPC_Instance_A_Auto_Recovery" {
  alarm_name          = "${local.ENV_Tag}-VPC Instance A Auto Recovery"
  namespace           = "AWS/EC2"
  evaluation_periods  = "1"
  period              = "60"
  alarm_description   = "${local.ENV_Tag}- Recovery of the EC2 Instance in ${local.Availability_zone_A} zone."
  alarm_actions       = ["arn:aws:automate:${local.Availability_zone_A}:ec2:recover"]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"
  metric_name         = "StatusCheckFailed_System"

  dimensions = {
    InstanceId = aws_instance.VPC_EC2_Instance_A.id
  }
}

resource "aws_cloudwatch_metric_alarm" "VPC_Instance_B_Auto_Recovery" {
  alarm_name = "${local.ENV_Tag}VPC Instance B Auto Recovery"

  namespace           = "AWS/EC2"
  evaluation_periods  = "1"
  period              = "60"
  alarm_description   = "${local.ENV_Tag} Recovery of the EC2 Instance in ${local.Availability_zone_B} zone."
  alarm_actions       = ["arn:aws:automate:${local.Availability_zone_B}:ec2:recover"]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"
  metric_name         = "StatusCheckFailed_System"

  dimensions = {
    InstanceId = aws_instance.VPC_EC2_Instance_B.id
  }
}
