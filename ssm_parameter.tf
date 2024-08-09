#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "elasticache_ep" {
  name  = "/elasticache/${var.name}/endpoint"
  type  = "SecureString"
  value = aws_elasticache_cluster.cache_cluster.configuration_endpoint
}