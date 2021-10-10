#===========================================================================================
# Rainbow Gravity's Template homework
#
# Application Load Balancer, Listeners and Target Groups
#===========================================================================================

resource "aws_lb" "VPC_Load_Balancer" {
  name_prefix = "${var.Tags["Environment"]}-"

  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.VPC_Public_Subnet.*.id
  security_groups    = [aws_security_group.VPC_Load_Security_Group.id]

  tags = local.ALB_Tags
}

resource "aws_lb_listener" "VPC_Load_Balancer_Listener_80" {

  load_balancer_arn = aws_lb.VPC_Load_Balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  }
}

resource "aws_lb_target_group" "VPC_Target_Group" {
  name_prefix = "${var.Tags["Environment"]}-"

  vpc_id   = aws_vpc.Homework_VPC.id
  port     = 80
  protocol = "HTTP"

  health_check {
    port                = var.Health_Check.port
    healthy_threshold   = var.Health_Check.healthy_threshold
    unhealthy_threshold = var.Health_Check.unhealthy_threshold
    timeout             = var.Health_Check.timeout
    interval            = var.Health_Check.interval
    matcher             = var.Health_Check.matcher
  }
}


