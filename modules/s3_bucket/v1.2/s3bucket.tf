resource "aws_s3_bucket" "main" {

  bucket        = var.bucket
  acl           = var.acl
  force_destroy = var.force_destroy

  tags = merge(
    {
      "Name" = var.bucket
    },
    var.s3_tags,
  )

  dynamic "logging" {
    for_each = var.logging_inputs == null ? [] : var.logging_inputs

    content {
      target_bucket = logging.value["target_bucket"]
      target_prefix = logging.value["target_prefix"]
    }
  }

  dynamic "versioning" {
    for_each = var.versioning_inputs == null ? [] : var.versioning_inputs

    content {
      enabled    = versioning.value["enabled"]
      mfa_delete = versioning.value["mfa_delete"]
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule_inputs == null ? [] : var.lifecycle_rule_inputs

    content {
      id                                     = lifecycle_rule.value["id"]
      prefix                                 = lifecycle_rule.value["prefix"]
      enabled                                = lifecycle_rule.value["enabled"]
      abort_incomplete_multipart_upload_days = lifecycle_rule.value["abort_incomplete_multipart_upload_days"]

      dynamic "expiration" {
        for_each = lifecycle_rule.value["expiration_inputs"] == null ? [] : lifecycle_rule.value["expiration_inputs"]

        content {
          days                         = expiration.value["days"]
          expired_object_delete_marker = expiration.value["expired_object_delete_marker"]
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value["transition_inputs"] == null ? [] : lifecycle_rule.value["transition_inputs"]

        content {
          days          = transition.value["days"]
          storage_class = transition.value["storage_class"]
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value["noncurrent_version_transition_inputs"] == null ? [] : lifecycle_rule.value["noncurrent_version_transition_inputs"]

        content {
          days          = noncurrent_version_transition.value["days"]
          storage_class = noncurrent_version_transition.value["storage_class"]
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value["noncurrent_version_expiration_inputs"] == null ? [] : lifecycle_rule.value["noncurrent_version_expiration_inputs"]

        content {
          days = noncurrent_version_expiration.value["days"]
        }
      }
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.server_side_encryption_configuration_inputs == null ? [] : var.server_side_encryption_configuration_inputs

    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = server_side_encryption_configuration.value["sse_algorithm"]
        }
      }
    }
  }
}


resource "aws_s3_bucket_public_access_block" "s3_bucket_block_public_access" {
  count                   = var.block_public_access == true ? 1 : 0
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  ignore_public_acls      = var.ignore_public_acls
  bucket                  = aws_s3_bucket.main.id
}