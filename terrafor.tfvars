region = "us-east-1"
secret_key = "value"
access_key = "value"


account_id = "value"
object_ownership = "BucketOwnerPreferred"
versioning = "Enabled"
kms_key_arn = "alias/aws/s3"
ss3_algorithm = "aws:kms"
block_public_acls = true
block_public_policy = true
ignore_public_acls = true
restrict_public_buckets = true
tags = {
  "Name" = "s3bucket"
}

bucketacl = "private"
organization_id = "value"