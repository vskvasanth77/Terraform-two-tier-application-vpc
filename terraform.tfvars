
#modules variable

cidr_block_vpc = "10.0.0.0/16"
cidr_all_block = "0.0.0.0/0"
port_number_public  = [22, 80, 3306, 443]
port_number_private = [22, 80, 3306, 443]
port_number_alb = [ 22,80,443 ]
protocol_name       = "tcp"
ebs_storage_size    = 8
ebs_storage_type    = "gp2"
ami_id              = "Enter your ami id"
ec2_type            = "t2.micro"
key                 = "source_key"
lb_type             = "application"
