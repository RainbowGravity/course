#----------------------------------------------------------------------
# Rainbow Gravity's CloudFormation Template homework
# 
# VPC Instances
#----------------------------------------------------------------------

resource "aws_instance" "Ubuntu_A" {
  ami                    = data.aws_ami.Ubuntu_Latest.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.VPC_Private_Subnet_A.id
  availability_zone      = data.aws_availability_zones.Available.names[0]
  vpc_security_group_ids = [aws_security_group.VPC_Dynamic_Security_Group.id]
  user_data              = file("./web-server.sh")

  tags = {
    Name    = "EC2 Instance A"
    Owner   = "Rainbow Gravity"
    Project = "Homework"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "Ubuntu_B" {

  ami                    = data.aws_ami.Ubuntu_Latest.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.VPC_Private_Subnet_B.id
  availability_zone      = data.aws_availability_zones.Available.names[1]
  vpc_security_group_ids = [aws_security_group.VPC_Dynamic_Security_Group.id]
  user_data              = file("./web-server.sh")

  tags = {
    Name    = "EC2 Instance B"
    Owner   = "Rainbow Gravity"
    Project = "Homework"
  }
  lifecycle {
    create_before_destroy = true
  }
}
