resource "aws_instance" "ctxcloud-ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  metadata_options {
    http_tokens = "optional"  # IMDSv2 is not required
  }

  tags = {
    Name = var.instance_name
  }
}

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