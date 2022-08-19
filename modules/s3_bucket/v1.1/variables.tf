#########################
### KMS key variables ###
#########################

variable "region" {
  description = "The name of the key alias"
  type        = string
  default     = ""
}

variable "alias_name" {
  description = "The name of the key alias"
  type        = string
}

variable "deletion_window_in_days" {
  description = "The duration in days after which the key is deleted after destruction of the resource"
  type        = number
  default     = 30
}

variable "description" {
  description = "The description of this KMS key"
  type        = string
}

variable "kms_key_policy_rendered" {
  description = "KMS key policy json"
  type        = string
}

###########################
### S3 Bucket variables ###
###########################

variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "acceleration_status" {
  description = "(Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended."
  default     = null
}

variable "logging_inputs" {
  type = list(object({
    target_bucket = string
    target_prefix = string
  }))
  default = null
}

variable "versioning_inputs" {
  type = list(object({
    enabled    = string
    mfa_delete = string
  }))
}

// Lifecycle rules variables:
variable "lifecycle_rule_inputs" {
  type = list(object({
    id                                     = string
    prefix                                 = string
    enabled                                = string
    abort_incomplete_multipart_upload_days = string
    expiration_inputs = list(object({
      days                         = number
      expired_object_delete_marker = string
    }))
    transition_inputs = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_transition_inputs = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_expiration_inputs = list(object({
      days = number
    }))
  }))
}

// Server side encryption config:
variable "server_side_encryption_configuration_inputs" {
  type = list(object({
    sse_algorithm     = string
    kms_master_key_id = string
  }))
  default = null
}

variable "s3_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}


##################################
### S3 bucket policy variables ###
##################################

variable "bucket_policy_rendered" {
  description = "S3 bucket policy document (json) rendered."
  type        = string
  default     = null
}

variable "block_public_access" {
  description = "Block Public Access enabled on bucket level"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "S3 Block public access control lists"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "S3 Block public policy"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "S3 restrict_public_buckets"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "S3 ignore public acls"
  type        = bool
  default     = true
}