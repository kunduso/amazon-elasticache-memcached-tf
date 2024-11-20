#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "instance_sg" {
  name        = "${var.name}_ec2_allow_inbound_access"
  description = "manage traffic for ${var.name} EC2"
  vpc_id      = module.vpc.vpc.id
  tags = {
    "Name" = "${var.name}-sg-ec2"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "egress_instance_sg" {
  description       = "allow traffic to reach outside the vpc"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_sg.id
}