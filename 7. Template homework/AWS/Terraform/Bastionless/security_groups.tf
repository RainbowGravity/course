#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Security groups
#===========================================================================================

resource "aws_security_group" "VPC_Load_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  dynamic "ingress" {
    for_each = var.Load_Security_Group_Ports
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
  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-Load Balancer security group" })
}

resource "aws_security_group" "VPC_Instances_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  dynamic "ingress" {
    for_each = var.Instances_Security_Group_Ports
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
  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-Instances security group" })
}

resource "aws_security_group" "VPC_SSM_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  ingress = [
    {
      description      = "Connections SSM instances"
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
  tags = merge(var.Tags, { Name = "${var.Tags["Environment"]}-SSM security group" })
}
