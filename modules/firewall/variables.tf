variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "fw_ami" {
  description = "AMI ID for the firewall"
  type        = string
}

variable "fw_instance_type" {
  description = "Instance type for the firewall"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}