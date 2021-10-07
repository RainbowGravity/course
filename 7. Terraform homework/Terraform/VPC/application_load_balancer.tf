#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
#
# Application Load Balancer, Listeners and Target Groups
#----------------------------------------------------------------------

resource "aws_lb" "VPC_Load_Balancer" {

  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.VPC_Public_Subnet_A.id, aws_subnet.VPC_Public_Subnet_B.id]
  security_groups    = [aws_security_group.VPC_Dynamic_Security_Group.id]

  tags = {
    Name    = "VPC Load Balancer"
    Owner   = "Rainbow Gravity"
    Project = "Homework"
  }

  depends_on = [aws_vpc.Homework_VPC]
}

resource "aws_lb_target_group" "VPC_Target_Group" {
  name     = "vpc-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Homework_VPC.id

  health_check {
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "VPC_attachment_A" {
  target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  target_id        = aws_instance.Ubuntu_A.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "VPC_attachment_B" {
  target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  target_id        = aws_instance.Ubuntu_B.id
  port             = 80
}

resource "aws_lb_listener" "VPC_Load_Balancer_Listener_80" {
  load_balancer_arn = aws_lb.VPC_Load_Balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.VPC_Target_Group.arn
  }
}

# resource "aws_lb_listener" "VPC_Load_Balancer_Listener_443" {
#   load_balancer_arn = aws_lb.VPC_Load_Balancer.arn
#   port              = "443"
#   protocol          = "HTTPS"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "80"
#       protocol    = "HTTP"
#       status_code = "HTTP_301"
#     }
#   }
# }
