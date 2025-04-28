variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-west-2a"
}

variable "fw_ami" {
  description = "AMI ID for the Palo Alto Networks NGFW (e.g., VM-Series AMI)"
  type        = string
  # Replace with an actual VM-Series AMI ID for your region
  default     = "ami-xxxxxxxxxxxxxxxxx"
}

variable "fw_instance_type" {
  description = "Instance type for the firewall"
  type        = string
  default     = "m5.xlarge"
}

variable "k8s_ami_id" {
  description = "AMI ID for the Kubernetes server (e.g., Ubuntu AMI)"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Example Ubuntu AMI, replace with actual
}

variable "k8s_instance_type" {
  description = "Instance type for the Kubernetes server"
  type        = string
  default     = "t3.medium"
}

variable "honeypot_ami_id" {
  description = "AMI ID for the honeypot instance (e.g., Ubuntu AMI)"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Example Ubuntu AMI, replace with current one
}

variable "honeypot_instance_type" {
  description = "Instance type for the honeypot"
  type        = string
  default     = "t3.micro"
}

variable "dshield_email" {
  description = "Email for DShield account"
  type        = string
}

variable "dshield_api_key" {
  description = "API key for DShield account"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair for instance access"
  type        = string
}