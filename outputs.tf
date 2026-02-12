output "bastion_instance_id" {
  description = "Instance ID of the bastion (used in SSM commands)"
  value       = aws_instance.bastion.id
}

output "vpc_id" {
  description = "VPC ID (useful for peering with target VPC)"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "bastion_security_group_id" {
  description = "Security group ID of bastion (targets must allow this SG)"
  value       = aws_security_group.bastion.id
}
