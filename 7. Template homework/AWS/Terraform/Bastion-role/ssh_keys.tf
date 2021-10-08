#===========================================================================================
# Rainbow Gravity's Template homework
# 
# VPC SSH Key Pairs
#===========================================================================================

resource "tls_private_key" "SSH_Private_Instances_Key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "SSH_Public_Instances_Key" {
  key_name   = local.SSH_Instances_Key
  public_key = tls_private_key.SSH_Private_Instances_Key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.SSH_Private_Instances_Key.private_key_pem}' > ~/.ssh/${local.SSH_Instances_Key}.pem" #chmod 400 ~/.ssh/${local.SSH_Instances_Key}.pem"
  }
}

resource "tls_private_key" "SSH_Private_Bastion_Key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "SSH_Public_Bastion_Key" {
  key_name   = local.SSH_Bastion_Key
  public_key = tls_private_key.SSH_Private_Bastion_Key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.SSH_Private_Bastion_Key.private_key_pem}' > ~/.ssh/${local.SSH_Bastion_Key}.pem" #chmod 400 ~/.ssh/${local.SSH_Bastion_Key}.pem"
  }
}
