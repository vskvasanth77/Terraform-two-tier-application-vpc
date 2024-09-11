variable "port_number_public_module" {
    description = "port number for public module" 
   type = list(number)

}
variable "cidr_all_block_module" {
    description = "cidr for the security group"
    type = string

  
}

variable "port_number_private_module" {
    description = "port number for private module"  
    type = list(number)
 
}
variable "port_number_alb_module" {
    description = "port number for private module"  
    type = list(number)
 
}

variable "protocol_name_module" {
    description = "portocol name"
    type = string

  
}

variable "vpd_id" {
    description = "vpc id added here"
    type = string
  
}