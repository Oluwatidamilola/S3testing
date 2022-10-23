resource "aws_s3_bucket" "ResouceSyncBucket" {
  bucket =  "ssm-resource-sync-${var.region}-${var.account_id}"
    tags = var.tag
}

resource "aws_s3_bucket_ownership_controls" "ResouceSyncBucket" {
  bucket = aws_s3_bucket.ResouceSyncBucket.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.ResouceSyncBucket.id

  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ResouceSyncBucket" {
  bucket = aws_s3_bucket.ResouceSyncBucket.id

  rule {
    apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm = var.ss3_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "accesscontrols" {
  bucket = aws_s3_bucket.ResouceSyncBucket.id

  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls = var.block_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "bucketacl" {
  bucket = aws_s3_bucket.ResouceSyncBucket.id
  acl    = "private"
}
  

#S3 bucket policy ResoucSyncBucketPolicy

resource "aws_s3_bucket_policy" "name" {
  bucket = aws_s3_bucket.ResouceSyncBucket.id
  policy = <<POLICY
{ 
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "SSMBucketPermissionsCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "${aws_s3_bucket.ResouceSyncBucket.arn}"
    },
    {
      "Sid": "SSMBucketDelivery",
      "Effect": "Allow",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws-us-gov:s3:::${aws_s3_bucket.ResouceSyncBucket.id}/*",
      "condition": {
        "StringEquals": {
          "s3:x-amz-server-side-encryption": "aws:kms",
          "s3:x-amz-server-side-encryption-aws-kms-key-id": "${var.kms_key_arn}",
          "s3:x-amz-acl": "bucket-owner-full-control"
          "s3:RequestObjectTag/OrgId":"${var.organization_id}"
        }
      }
    },
    {
      "Sid": "SSMWrite",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": "arn:aws-us-gov:s3:::${aws_s3_bucket.ResouceSyncBucket.id}/*",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalOrgID":"${var.organization_id}"
        }
      }
    },
    {
      "Sid": "SSMBucketDeliveryTagging",
      "Effect": "Allow",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Action": "s3:PutObjectTagging",
      "Resource": "arn:aws-us-gov:s3:::${aws_s3_bucket.ResouceSyncBucket.id}/*/accountid=${var.account_id}",
    }
  ]
}
POLICY
}