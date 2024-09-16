resource "aws_eip" "nat_elastic_ip" {
    domain = "vpc"
  
}
resource "aws_nat_gateway" "nat_igw_local" {
    allocation_id = aws_eip.nat_elastic_ip.id
    subnet_id = var.public_subnet_1_id
  
}

output "nat_igw_id" {
    value = aws_nat_gateway.nat_igw_local.id
  
}