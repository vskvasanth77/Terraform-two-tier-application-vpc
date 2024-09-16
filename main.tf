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
  nat_igw_id = module.nat_module.nat_igw_id

}

module "internet_gateway_module" {
  source = "./modules/internet_gateway"
  vpd_id = module.vpc_test.aws_vpc_id
  
}

module "nat_module" {
  source = "./modules/nat_gateway"
  public_subnet_1_id = module.subnet_module.subnet_1
  
}

module "security_group_module" {
  source = "./modules/security_group"
  vpd_id = module.vpc_test.aws_vpc_id
  port_number_public_module = var.port_number_private
  port_number_private_module = var.port_number_private
  protocol_name_module = var.protocol_name
  cidr_all_block_module = var.cidr_all_block
  port_number_alb_module = var.port_number_alb
}

module "ebs_module" {
  source = "./modules/ebs"
  ebs_storage_size_module = var.ebs_storage_size
  ebs_storage_type_module = var.ebs_storage_type
  pub_1_sub_az = module.subnet_module.subnet_az
}

module "ec2_module" {
  source = "./modules/ec2_instance"
  ami_id_module = var.ami_id
  ec2_type_module = var.ec2_type
  key_module = var.key
  subnet_id_1_module = module.subnet_module.subnet_1
  subnet_id_2_module = module.subnet_module.subnet_2
  subnet_id_3_module = module.subnet_module.subnet_3
  subnet_id_4_module = module.subnet_module.subnet_4
  public_sg_module = module.security_group_module.pub_sg_id
  private_sg_module = module.security_group_module.pri_sg_id
  
}

module "alb_module" {
  source = "./modules/alb"
  lb_type_module = var.lb_type
  vpd_id = module.vpc_test.aws_vpc_id
  alb_sg_gp = module.security_group_module.alb_sg_id
  pub_subnet_1 = module.subnet_module.subnet_1
  pub_subnet_2 = module.subnet_module.subnet_2
  public_ec2_id = module.ec2_module.public_ec2_1
}




