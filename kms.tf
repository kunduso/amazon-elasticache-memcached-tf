resource "aws_kms_key" "encrypt_ssm" {
  enable_key_rotation     = true
  description             = "Key to encrypt ssm"
  deletion_window_in_days = 7
  #checkov:skip=CKV2_AWS_64: Not including a KMS Key policy
}
resource "aws_kms_alias" "encryption_secret" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.encrypt_ssm.key_id
}
resource "aws_kms_key_policy" "encrypt_ssm_policy" {
  key_id = aws_kms_key.encrypt_ssm.id
  policy = data.aws_iam_policy_document.encrypt_ssm_policy.json
}

data "aws_iam_policy_document" "encrypt_ssm_policy" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:Describe*",
      "kms:List*",
      "kms:Get*",
      "kms:RotateKey",
      "kms:EnableKey",
      "kms:DisableKey",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:PutKeyPolicy",
      "kms:DeleteAlias"
    ]
    resources = [aws_kms_key.encrypt_ssm.arn]
  }

  statement {
    sid    = "Allow SSM to use the key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = [aws_kms_key.encrypt_ssm.arn]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["ssm.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
}
