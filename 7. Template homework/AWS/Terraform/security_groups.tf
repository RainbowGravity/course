#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Security groups
#===========================================================================================

resource "aws_security_group" "VPC_Load_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  description = "Load balancer ports"

  dynamic "ingress" {
    for_each = var.Load_Security_Group_Ports
    content {
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
  tags = local.Load_Security_Group
}

resource "aws_security_group" "VPC_Instances_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  dynamic "ingress" {
    for_each = var.Instances_Security_Group_Ports
    content {
      description      = "EC2 Instances ports"
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
  tags = local.Instances_Security_Group
}

resource "aws_security_group" "VPC_SSM_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  ingress = [
    {
      description      = "Ports for SSM"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

      prefix_list_ids = null
      security_groups = null
      self            = null
    }
  ]
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
  tags = local.SSM_Security_Group
}
