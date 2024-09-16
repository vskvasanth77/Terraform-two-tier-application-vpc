#ec2-instance_creation

resource "aws_instance" "public_ec2_A" {
  ami           = var.ami_id_module
  instance_type = var.ec2_type_module
  key_name      = var.key_module

  #public subnet
    subnet_id = var.subnet_id_1_module
    security_groups = [var.public_sg_module]

  #lifecycle
  lifecycle {
    ignore_changes = [security_groups]
  }

  tags = {
    Name = "pubic-ec2-A"
  }
 user_data = file("./inline.sh") 


}

resource "aws_instance" "public_ec2_B" {
  ami           = var.ami_id_module
  instance_type = var.ec2_type_module
  key_name      = var.key_module

  #public subnet
  subnet_id       = var.subnet_id_2_module
  security_groups = [var.public_sg_module]

  #lifecycle
  lifecycle {
    ignore_changes = [security_groups]
  }

  tags = {
    Name = "pubic-ec2-B"
  }
user_data = file("./inline.sh") 
    
}


resource "aws_instance" "private_ec2_A" {
  ami           = var.ami_id_module
  instance_type = var.ec2_type_module
  key_name      = var.key_module

  #private subnet

  subnet_id       = var.subnet_id_3_module
  security_groups = [var.private_sg_module]
  #lifecycle
  lifecycle {
    ignore_changes = [security_groups]
  }

  tags = {
    Name = "private-ec2-A"
  }

}
resource "aws_instance" "private_ec2_B" {
  ami           = var.ami_id_module
  instance_type = var.ec2_type_module
  key_name      = var.key_module

  #private subnet

  subnet_id       = var.subnet_id_4_module
  security_groups = [var.private_sg_module]
  #lifecycle
  lifecycle {
    ignore_changes = [security_groups]
  }

  tags = {
    Name = "private-ec2-A"
  }

}

output "public_ec2_1" {
    value = aws_instance.public_ec2_A.id
  
}


