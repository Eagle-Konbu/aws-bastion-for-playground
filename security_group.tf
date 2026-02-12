resource "aws_security_group" "bastion" {
  name        = "${var.project_name}-bastion-sg"
  description = "Security group for SSM bastion - no inbound, outbound to targets and SSM"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.project_name}-bastion-sg" }
}

# HTTPS outbound - required for SSM agent to reach SSM service endpoints
resource "aws_vpc_security_group_egress_rule" "https_to_internet" {
  security_group_id = aws_security_group.bastion.id
  description       = "HTTPS to SSM service endpoints"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

# Outbound to VPC internal targets (RDS, ALB, etc.)
resource "aws_vpc_security_group_egress_rule" "to_vpc_targets" {
  security_group_id = aws_security_group.bastion.id
  description       = "Access to internal targets within VPC"
  ip_protocol       = "-1"
  cidr_ipv4         = var.vpc_cidr
}
