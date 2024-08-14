data "aws_ami" "windows-ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"]
    #values = ["Windows_Server-2019-English-Full-Base-2023*"] // for linux "amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"
  }
#   filter {
#     name   = "platform"
#     values = ["windows"]
#   }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "write_instance" {
  instance_type               = "t3.medium"
  ami                         = data.aws_ami.windows-ami.id
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
    ebs_optimized = true
  monitoring    = true
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  user_data = templatefile("user_data/write_elasticache.tpl",
    {
      Region                 = var.region,
      elasticache_ep         = aws_ssm_parameter.elasticache_ep.name
  })
  tags = {
    Name = "${var.name}-server-1"
  }
}