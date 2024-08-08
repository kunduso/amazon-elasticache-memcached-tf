#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster
resource "aws_elasticache_cluster" "cache_cluster" {
  cluster_id           = var.name
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
  security_group_ids = [aws_security_group.custom_sg.id]
}