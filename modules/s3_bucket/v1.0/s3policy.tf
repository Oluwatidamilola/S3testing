resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.bucket_policy_rendered != null ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = var.bucket_policy_rendered
}
