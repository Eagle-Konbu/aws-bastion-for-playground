output "bastion_instance_id" {
  description = "Instance ID of the bastion (used in SSM commands)"
  value       = aws_instance.bastion.id
}

output "vpc_id" {
  description = "VPC ID (useful for peering with target VPC)"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "bastion_security_group_id" {
  description = "Security group ID of bastion"
  value       = aws_security_group.bastion.id
}

output "bastion_target_security_group_id" {
  description = "Security group ID to attach to resources accessed via bastion"
  value       = aws_security_group.bastion_target.id
}
