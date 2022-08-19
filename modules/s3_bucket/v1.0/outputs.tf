#######################
### KMS Key outputs ###
#######################
output "key_name" {
  value = aws_kms_key.key.id
}

output "key_arn" {
  value = aws_kms_key.key.arn
}

#########################
### S3 Bucket outputs ###
#########################
output "bucket_name" {
  value = aws_s3_bucket.main.id
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}
