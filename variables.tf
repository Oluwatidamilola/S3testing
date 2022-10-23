
variable "region" {
  description = "value of region the bucket is going to deploy"
    type = string
    default = "us-east-1"
}
  
variable "account_id" {
  description = "value of account_id the bucket is going to deploy"
    type = string
    default = "123456789012"
}

variable "object_ownership" {
  description = "The Object Ownership setting for the bucket. Must be either ObjectWriter or BucketOwnerPreferred."
    type        = string
    default     = "BucketOwnerPreferred"
}

variable "versioning" {
  description = "The versioning state of the bucket. Must be either Enabled or Suspended."
    type        = string
    default     = "Enabled"
}

variable "kms_key_arn" {
  description = "The KMS key ID to use for the default encryption."
    type        = string
    default     = "alias/aws/s3"
}
  
variable "ss3_algorithm" {
  description = "The server-side encryption algorithm to use. Must be either AES256 or aws:kms."
    type        = string
    default     = "aws:kms"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public access control lists (ACLs) for this bucket and objects in this bucket. Defaults to true."
    type        = bool
    default     = true
}
  
variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket. Defaults to true."
    type        = bool
    default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket and objects in this bucket. Defaults to true."
    type        = bool
    default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to true."
    type        = bool
    default     = true
}

variable "tag" {
  description = "A map of tags to assign to the bucket."
    type        = map(string)
    default     = {
        Name = "ssm-resource-sync"
    }
}

variable "bucketacl" {
  description = "The canned ACL to apply. Defaults to private. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, log-delivery-write, bucket-owner-read, bucket-owner-full-control, and bucket-owner-full-control."
    type        = string
    default     = "private"
}

variable "organization_id" {
  description = "The organization ID."
    type        = string
    default     = "o-123456789012"
}