#Create a policy to read from the specific parameter store
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "ssm_parameter_policy" {
  name        = "${var.name}-ssm-parameter-read-policy"
  path        = "/"
  description = "Policy to read the ElastiCache endpoint stored in the SSM Parameter Store."
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        Resource = [aws_ssm_parameter.elasticache_ep.arn]
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ]
        Resource = [aws_kms_key.encrypt_ssm.arn]
      }
    ]
  })
}