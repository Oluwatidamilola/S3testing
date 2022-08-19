resource "aws_kms_key" "key" {
  description             = var.description
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = var.kms_key_policy_rendered
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = true
  enable_key_rotation     = true
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.key.id
}
