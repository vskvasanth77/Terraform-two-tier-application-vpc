resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block1
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vas_vpc"
  }


}

output "aws_vpc_id" {
  value = aws_vpc.main.id
}
