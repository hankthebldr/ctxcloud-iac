variable "subnet_id" {
  description = "ID of the subnet for the honeypot instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the honeypot instance (e.g., Ubuntu AMI)"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the honeypot"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for accessing the instance"
  type        = string
}

variable "dshield_email" {
  description = "Email for DShield account"
  type        = string
}

variable "dshield_api_key" {
  description = "API key for DShield account"
  type        = string
}