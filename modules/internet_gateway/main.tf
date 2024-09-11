##internetgateway

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = var.vpd_id 

  tags = {
    Name = "vpc-igw"
  }

}

output "igw_id" {
    value = aws_internet_gateway.vpc-igw.id
  
}
