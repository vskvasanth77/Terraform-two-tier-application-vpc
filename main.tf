provider "aws" {
  region = "us-east-1"
}

#vpc_creation

module "vpc_test" {
  source = "./modules/vpc"
  cidr_block1  = var.cidr_block_vpc
}

module "subnet_module"{
  source = "./modules/subnet"
  vpd_id = module.vpc_test.aws_vpc_id
}

module "route_module" {
  source = "./modules/route_table"
  vpd_id = module.vpc_test.aws_vpc_id
  cidr_all_block_child = var.cidr_all_block
  subnet_1 = module.subnet_module.subnet_1
  subnet_2 = module.subnet_module.subnet_2
  subnet_3 = module.subnet_module.subnet_3
  subnet_4 = module.subnet_module.subnet_4
  igw_id = module.internet_gateway_module.igw_id

}

module "internet_gateway_module" {
  source = "./modules/internet_gateway"
  vpd_id = module.vpc_test.aws_vpc_id
  
}

module "security_group_module" {
  source = "./modules/security_group"
  vpd_id = module.vpc_test.aws_vpc_id
  port_number_public_module = var.port_number_private
  port_number_private_module = var.port_number_private
  protocol_name_module = var.protocol_name
  cidr_all_block_module = var.cidr_all_block
}

module "ebs_module" {
  source = "./modules/ebs"
  ebs_storage_size_module = var.ebs_storage_size
  ebs_storage_type_module = var.ebs_storage_type
  pub_1_sub_az = module.subnet_module.subnet_az
}


# resource "aws_vpc" "main" {
#   cidr_block           = var.cidr_block_vpc
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "vas_vpc"
#   }

# }

#subnet

# resource "aws_subnet" "public-1" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"


#   tags = {
#     Name = "public_subnet_1A"
#   }
# }
# resource "aws_subnet" "public-2" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.2.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1b"

#   tags = {
#     Name = "public_subnet_2A"
#   }
# }

# resource "aws_subnet" "private-1" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.3.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "private_subnet_1A"
#   }

# }


# resource "aws_subnet" "private-2" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.4.0/24"
#   availability_zone = "us-east-1b"

#   tags = {
#     Name = "private_subnet_2A"
#   }

# }
# ##route table

# resource "aws_route_table" "public_route" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = var.cidr_all_block
#     gateway_id = aws_internet_gateway.vpc-igw.id
#   }

#   tags = {
#     Name = "public_route_table"
#   }

# }

# resource "aws_route_table" "private_route" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "private_route_table"
#   }

# }

# ##association to route_table

# resource "aws_route_table_association" "public_association_1" {
#   subnet_id      = aws_subnet.public-1.id
#   route_table_id = aws_route_table.public_route.id
# }
# resource "aws_route_table_association" "public_association_2" {
#   subnet_id      = aws_subnet.public-2.id
#   route_table_id = aws_route_table.public_route.id
# }

# resource "aws_route_table_association" "private_association_1" {
#   subnet_id      = aws_subnet.private-1.id
#   route_table_id = aws_route_table.private_route.id
# }
# resource "aws_route_table_association" "private_association_2" {
#   subnet_id      = aws_subnet.private-2.id
#   route_table_id = aws_route_table.private_route.id
# }



# ##internetgateway

# resource "aws_internet_gateway" "vpc-igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "vpc-igw"
#   }

# }

# ######################################

# #security group

# resource "aws_security_group" "public-sg" {
#   vpc_id      = aws_vpc.main.id
#   description = "public-security-group"
#   dynamic "ingress" {
#     for_each = var.port_number_public

#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = [var.cidr_all_block]
#     }

#   }

#   dynamic "egress" {
#     for_each = var.port_number_public
#     content {
#       from_port   = egress.value
#       to_port     = egress.value
#       protocol    = var.protocol_name
#       cidr_blocks = [var.cidr_all_block]

#     }

#   }

# }


# resource "aws_security_group" "private-sg" {
#   vpc_id      = aws_vpc.main.id
#   description = "private-security-group"

#   dynamic "ingress" {
#     for_each = var.port_number_private
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = var.protocol_name
#       cidr_blocks = [var.cidr_all_block]

#     }

#   }

#   dynamic "egress" {
#     for_each = var.port_number_private
#     content {
#       from_port   = egress.value
#       to_port     = egress.value
#       protocol    = var.protocol_name
#       cidr_blocks = [var.cidr_all_block]
#     }

#   }
   
# }

# #ebs_volume creation

# resource "aws_ebs_volume" "ebs-gp2" {
#   availability_zone = aws_subnet.public-1.availability_zone
#   size              = var.ebs_storage_size
#   type              = var.ebs_storage_type

#   tags = {
#     Name = "ebs_vas_vpc"

#   }


# }
# #######################################

# #ec2-instance_creation

# resource "aws_instance" "public_ec2_A" {
#   ami           = var.ami_id
#   instance_type = var.ec2_type
#   key_name      = var.key

#   #public subnet
#   subnet_id       = aws_subnet.public-1.id
#   security_groups = [aws_security_group.public-sg.id]

#   #lifecycle
#   lifecycle {
#     ignore_changes = [security_groups]
#   }

#   tags = {
#     Name = "pubic-ec2-A"
#   }

#   user_data = <<-EOF
#     #!/bin/bash
#     sudo apt update -y
#     sudo apt install apache2 -y
#     sudo systemctl enable apache2
#     sudo systemctl start apache2
#   EOF

#   # connection {
#   #   type        = "ssh"
#   #   user        = "ubuntu"
#   #   private_key = file("./source_key.pem")
#   #   host        = self.public_ip
#   # }
#   # provisioner "remote-exec" {
#   #   inline = ["sudo apt update -y", "sudo apt install apache2 -y", "sudo systemctl enable apache2", "sudo systemctl start apache2", "sudo systemctl status apache2"]
#   # }
# }

# resource "aws_instance" "public_ec2_B" {
#   ami           = var.ami_id
#   instance_type = var.ec2_type
#   key_name      = var.key

#   #public subnet
#   subnet_id       = aws_subnet.public-2.id
#   security_groups = [aws_security_group.public-sg.id]

#   #lifecycle
#   lifecycle {
#     ignore_changes = [security_groups]
#   }

#   tags = {
#     Name = "pubic-ec2-B"
#   }
# }


# # resource "aws_instance" "private_ec2_A" {
# #   ami           = var.ami_id
# #   instance_type = var.ec2_type
# #   key_name      = var.key

# #   #private subnet

# #   subnet_id       = aws_subnet.private-1.id
# #   security_groups = [aws_security_group.private-sg.id]

# #   #lifecycle
# #   lifecycle {
# #     ignore_changes = [security_groups]
# #   }

# #   tags = {
# #     Name = "private-ec2-A"
# #   }

# # }

# ######################################################################

# #application load balancer

# resource "aws_lb" "web-alb" {
#   name                             = "application-load-balancer"
#   load_balancer_type               = var.lb_type
#   security_groups                  = [aws_security_group.public-sg.id]
#   subnets                          = [ aws_subnet.public-1.id, aws_subnet.public-2.id]
#   enable_cross_zone_load_balancing = true

#   tags = {
#     Name = "vas-alb"
#   }

# }

# resource "aws_lb_target_group" "tg-alb" {
#   name     = "tg-alb"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2

#   }
#   tags = {
#     Name = "tg-alb-vas"
#   }

# }




# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.web-alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg-alb.arn
#   }

# }

# resource "aws_lb_target_group_attachment" "tg-alb-gp" {
#   target_group_arn = aws_lb_target_group.tg-alb.arn
#   target_id        = aws_instance.public_ec2_A.id
#   port             = 80

# }




