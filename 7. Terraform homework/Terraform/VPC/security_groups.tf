#----------------------------------------------------------------------
# Security groups
#----------------------------------------------------------------------

resource "aws_security_group" "VPC_Dynamic_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description      = "Connections to VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

      prefix_list_ids = null
      security_groups = null
      self            = null
    }
  }

  egress = [
    {
      description      = "Egress from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

      prefix_list_ids = null
      security_groups = null
      self            = null
    }
  ]
  tags = {
    Name = "Dynamic security group (80,443)"
  }
}
