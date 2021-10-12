#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC CloudWatch Alarm & Auto Recovery
#===========================================================================================

# Creating a CloudWatch alarms for each EC2 Instance and recover them on system fail
resource "aws_cloudwatch_metric_alarm" "VPC_Instance_Auto_Recovery" {
  count = (var.EC2_Per_Zone * var.Amount_of_Zones)

  alarm_name          = "${var.Environment_Tag}-VPC Instance #${tostring(count.index + 1)} ${local.Availability_zone[count.index % var.Amount_of_Zones]}"
  namespace           = "AWS/EC2"
  evaluation_periods  = "1"
  period              = "60"
  alarm_description   = "Recovery of the EC2 Instance #${tostring(count.index + 1)} in ${local.Availability_zone[count.index % var.Amount_of_Zones]} zone."
  alarm_actions       = ["arn:aws:automate:${local.Current_region}:ec2:recover"]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"
  metric_name         = "StatusCheckFailed_System"

  dimensions = {
    InstanceId = aws_instance.VPC_EC2_Instance[count.index].id
  }
}
