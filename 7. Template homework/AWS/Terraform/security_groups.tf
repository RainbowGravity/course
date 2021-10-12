#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Security groups
#===========================================================================================

# Creating a security group for the ALB
resource "aws_security_group" "VPC_Load_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  # Creating a list of the ALB open ports dynamically
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

# Creating a security group for the EC2 Instances
resource "aws_security_group" "VPC_Instances_Security_Group" {
  vpc_id = aws_vpc.Homework_VPC.id

  # Creating a list of the EC2 open ports dynamically
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

# Creating a security group for the SSM services
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
