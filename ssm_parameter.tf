#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "elasticache_ep" {
  name   = "/${var.name}/endpoint"
  type   = "SecureString"
  key_id = aws_kms_key.encrypt_ssm.id
  value  = aws_elasticache_cluster.cache_cluster.configuration_endpoint
}