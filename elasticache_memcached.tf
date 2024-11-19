#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group
resource "aws_elasticache_subnet_group" "elasticache_subnet" {
  name       = var.name
  subnet_ids = [for subnet in module.vpc.private_subnets : subnet.id]
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster
resource "aws_elasticache_cluster" "cache_cluster" {
  cluster_id           = var.name
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.6"
  engine_version       = "1.6.22"
  az_mode              = "cross-az"
  port                 = 11211
  network_type         = "ipv4"
  security_group_ids   = [aws_security_group.custom_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnet.name
  apply_immediately    = true
}