# #----------------------------------------------------------------------
# # Application Load Balancer
# #----------------------------------------------------------------------

# resource "aws_lb" "VPC_Load_Balancer" {
#   name            = "VPC Load Balancer"
#   vpc_id          = aws_vpc.Homework_VPC.id
#   subnets         = [aws_subnet.VPC_Private_Subnet_A.id, aws_subnet.VPC_Private_Subnet_B.id]
#   security_groups = [aws_security_group.Dynamic_Security_Group.id]

#   access_logs = {
#     bucket = "my-alb-logs"
#   }



#   listener = [
#     {
#       lb_port               = 80
#       lb_protocol           = "HTTP"
#       instance_port               = 80
#       instance_protocol           = "HTTP"
#       target_group_index = 0
#     }
#   ]

#   tags = {
#     Environment = "Test"
#   }
# }

resource "aws_lb_target_group" "homework-vpc-target-group" {
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
