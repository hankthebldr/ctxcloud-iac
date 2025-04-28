variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type to launch"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance into"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}
