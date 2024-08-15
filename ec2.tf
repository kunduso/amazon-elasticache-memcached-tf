data "aws_ami" "ec2_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "write_instance" {
  instance_type               = "t3.medium"
  ami                         = data.aws_ami.ec2_ami.id
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  ebs_optimized               = true
  monitoring                  = true
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  user_data = templatefile("user_data/write_elasticache.tpl",
    {
      Region         = var.region,
      elasticache_ep = aws_ssm_parameter.elasticache_ep.name
  })
  tags = {
    Name = "${var.name}-write-instance"
  }
  # checkov:skip=CKV_AWS_88: "EC2 instance should not have public IP."
  # This instance has the public IP to install the Python packages.
  # The alternative is to use the NAT instance to install the Python packages
  # but that would increase the cost and deviate from the primary objective of this use case.
  # Alternatively, I could create a custom AMI with the Python packages installed and use that instead.
  # That too would have deviated from the primary objective.
  # So, I am leaving it as is.
  # Moreover, the security group attached to the instance has no ingress on any port which
  # offers some protection from unauthorized access.
}

resource "aws_instance" "read_instance" {
  instance_type               = "t3.medium"
  ami                         = data.aws_ami.ec2_ami.id
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  subnet_id                   = aws_subnet.public[1].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  ebs_optimized               = true
  monitoring                  = true
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  user_data = templatefile("user_data/read_elasticache.tpl",
    {
      Region         = var.region,
      elasticache_ep = aws_ssm_parameter.elasticache_ep.name
  })
  tags = {
    Name = "${var.name}-read-instance"
  }
  # checkov:skip=CKV_AWS_88: "EC2 instance should not have public IP."
  # This instance has the public IP to install the Python packages.
  # The alternative is to use the NAT instance to install the Python packages
  # but that would increase the cost and deviate from the primary objective of this use case.
  # Alternatively, I could create a custom AMI with the Python packages installed and use that instead.
  # That too would have deviated from the primary objective.
  # So, I am leaving it as is.
  # Moreover, the security group attached to the instance has no ingress on any port which
  # offers some protection from unauthorized access.
}