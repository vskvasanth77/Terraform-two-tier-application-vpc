#ebs_volume creation

resource "aws_ebs_volume" "ebs-gp2" {
#   availability_zone = aws_subnet.public-1.availability_zone
  availability_zone = var.pub_1_sub_az
  size              = var.ebs_storage_size_module
  type              = var.ebs_storage_type_module

  tags = {
    Name = "ebs_vas_vpc"

  }


}