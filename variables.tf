variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "bastion-playground"
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

variable "instance_type" {
  description = "EC2 instance type for bastion"
  type        = string
  default     = "t4g.nano"
}
