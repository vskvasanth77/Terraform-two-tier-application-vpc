resource "aws_subnet" "public-1" {
  vpc_id                  = var.vpd_id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"


  tags = {
    Name = "public_subnet_1A"
  }
}
resource "aws_subnet" "public-2" {
  vpc_id                  = var.vpd_id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public_subnet_2A"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id            = var.vpd_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_1A"
  }

}


resource "aws_subnet" "private-2" {
  vpc_id            = var.vpd_id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet_2A"
  }

}

output "subnet_1" {
  value = aws_subnet.public-1.id
}
output "subnet_2" {
  value = aws_subnet.public-2.id
}
output "subnet_3" {
  value = aws_subnet.private-1.id
}
output "subnet_4" {
  value = aws_subnet.private-2.id
}

output "subnet_az" {
  value = aws_subnet.public-1.availability_zone_id
  
}