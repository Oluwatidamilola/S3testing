output "s3_bucket_kms_key_id" {
  value = aws_kms_key.key.id
}

output "s3_bucket_kms_key_arn" {
  value = aws_kms_key.key.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "s3_bucket_kms_key" {
  value = aws_kms_key.key
}

output "s3_bucket" {
  value = aws_s3_bucket.main
}