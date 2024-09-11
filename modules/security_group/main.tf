#security group

resource "aws_security_group" "public-sg" {
  vpc_id      = var.vpd_id
  description = "public-security-group"
  dynamic "ingress" {
    for_each = var.port_number_public_module

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_all_block_module]
    }

  }

  dynamic "egress" {
    for_each = var.port_number_public_module
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = var.protocol_name_module
      cidr_blocks = [var.cidr_all_block_module]

    }

  }

}


resource "aws_security_group" "private-sg" {
  vpc_id      = var.vpd_id
  description = "private-security-group"

  dynamic "ingress" {
    for_each = var.port_number_private_module
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol_name_module
      cidr_blocks = [var.cidr_all_block_module]

    }

  }

  dynamic "egress" {
    for_each = var.port_number_private_module
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = var.protocol_name_module
      cidr_blocks = [var.cidr_all_block_module]
    }

  }
   
}

output "pub_sg_id" {
    value =aws_security_group.public-sg.id
  
}
output "pri_sg_id" {
    value =aws_security_group.private-sg.id
  
}