variable "cidr_block_vpc" {
  type        = string
  description = "cidr block for vpc"
}

variable "cidr_all_block" {
  type        = string
  description = "cidr all access value block"

}

variable "port_number_public" {
  type        = list(number)
  description = "port for both public and private subnet"

}

variable "port_number_private" {
  type        = list(number)
  description = "port for both public and private subnet"

}

variable "protocol_name" {
  type        = string
  description = "value for protocol name"

}

# variable "ami_id" {
#   type        = string
#   description = "ami id for ubuntu"

# }

# variable "ec2_type" {
#   type        = string
#   description = "type of the instance"

# }

# variable "key" {
#   type        = string
#   description = "key_pair name"

# }

# variable "port_number_public" {
#   type        = list(number)
#   description = "port for both public and private subnet"

# }
# variable "port_number_private" {
#   type        = list(number)
#   description = "port for both public and private subnet"

# }

# variable "protocol_name" {
#   type        = string
#   description = "value for protocol name"

# }

# variable "ebs_storage_size" {
#   type        = number
#   description = "size of ebs"

# }

# variable "ebs_storage_type" {
#   type        = string
#   description = "type of ebs volume"

# }

# variable "lb_type" {
#   type        = string
#   description = "type of load balancer"

# }

# # variable "private_subnet_ids" {
# #   type        = list
# #   description = "list of private subnet ids"

# # }