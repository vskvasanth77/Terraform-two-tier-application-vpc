# cidr_block_vpc1    = "10.0.0.0/16"
# cidr_all_block      = "0.0.0.0/0"
# ami_id              = "ami-0e86e20dae9224db8"
# ec2_type            = "t2.micro"
# key                 = "source_key"
# port_number_public  = [22, 80, 3306, 443]
# port_number_private = [22, 80, 3306, 443]
# protocol_name       = "tcp"
# ebs_storage_size    = 8
# ebs_storage_type    = "gp2"
# lb_type             = "application"
# #private_subnet_ids  = ["aws_subnet.private-1.id", "aws_subnet.private-2.id"]



#modules variable

cidr_block_vpc = "10.0.0.0/16"
cidr_all_block = "0.0.0.0/0"
port_number_public  = [22, 80, 3306, 443]
port_number_private = [22, 80, 3306, 443]
protocol_name       = "tcp"
ebs_storage_size    = 8
ebs_storage_type    = "gp2"
ami_id              = "ami-0e86e20dae9224db8"
ec2_type            = "t2.micro"
key                 = "source_key"
