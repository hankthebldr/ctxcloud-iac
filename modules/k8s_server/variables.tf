variable "subnet_id" {
  description = "ID of the subnet for the Kubernetes server"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the Kubernetes server"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Kubernetes server"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}