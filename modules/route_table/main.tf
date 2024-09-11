##route table

resource "aws_route_table" "public_route" {
  vpc_id = var.vpd_id

  route {
    cidr_block = var.cidr_all_block_child
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public_route_table"
  }

}

resource "aws_route_table" "private_route" {
  vpc_id = var.vpd_id

  tags = {
    Name = "private_route_table"
  }

}

##association to route_table

resource "aws_route_table_association" "public_association_1" {
  subnet_id      = var.subnet_1
  route_table_id = aws_route_table.public_route.id
}
resource "aws_route_table_association" "public_association_2" {
  subnet_id      = var.subnet_2
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_association_1" {
  subnet_id      = var.subnet_3
  route_table_id = aws_route_table.private_route.id
}
resource "aws_route_table_association" "private_association_2" {
  subnet_id      = var.subnet_4
  route_table_id = aws_route_table.private_route.id
}