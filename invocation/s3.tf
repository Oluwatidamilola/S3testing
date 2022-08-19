module "s3" {
  source    = "../modules/s3_bucket/v1.2"

  //S3 bucket name
  bucket        = "ssm-execution-logs-${var.region}-${data.aws_caller_identity.current.account_id}"
  force_destroy = false
  #  S3 variable inside the policy!!!                = local.tags
  bucket_policy_rendered = templatefile("${path.module}/policies/s3_bucket_policy.json", {
    bucket_name = module.s3.s3_bucket.id
    principal_org_id = data.aws_organizations_organization.example.id
  })


  server_side_encryption_configuration_inputs = [{
    sse_algorithm = "AES256"
  }]

  versioning_inputs = [
    {
      enabled    = false
      mfa_delete = null
    },
  ]

  lifecycle_rule_inputs = [
    {
      id                                     = null
      enabled                                = true
      prefix                                 = ""
      abort_incomplete_multipart_upload_days = null
      expiration_inputs                      = []
      transition_inputs                      = []
      noncurrent_version_transition_inputs   = []
      noncurrent_version_expiration_inputs = [
        {
          days = 1
        }
      ]
    },
    {
      id                                     = "delete-marker-removal"
      enabled                                = true
      prefix                                 = ""
      abort_incomplete_multipart_upload_days = null
      expiration_inputs = [
        {
          days                         = 0
          expired_object_delete_marker = true
        }
      ]
      transition_inputs                    = []
      noncurrent_version_transition_inputs = []
      noncurrent_version_expiration_inputs = []
    }
  ]
}
