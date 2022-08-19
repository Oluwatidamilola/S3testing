# S3 Bucket V.1.0
## Overview
This module is used for the creation of a S3 bucket with bucket policy and KMS key .
The list of workloads to be created by v.1.0:

1. S3 bucket
2. S3 bucket policy
3. KMS key

```
This version is used for all deployments which utilise aws provider v.2.70. 
```

## Inputs
Inputs are values that module accepts and requires.

| Variable name    | Value type       | Default value | Required | Description |
|------------------|------------------|---------------|----------|-------------|
| acceleration_status | any | none | true | (Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended. |
| acl | string | private | false | (Optional) The canned ACL to apply. Defaults to 'private'. |
| alias_name | string | none | true | The name of the key alias |
| bucket | any | none | true | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. |
| bucket_policy_rendered | string | none | true | S3 bucket policy document (json) rendered. |
| deletion_window_in_days | number | 30 | false | The duration in days after which the key is deleted after destruction of the resource |
| description | string | none | true | The description of this KMS key |
| force_destroy | bool | false | false | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. |
| kms_key_policy_rendered | string | none | true | KMS key policy json |
| lifecycle_rule_inputs | list(object()) | none | true | none |
| logging_inputs | list(object()) | none | true | none |
| region | string |  | false | The name of the key alias |
| s3_tags | map(string) | {} | false | Additional tags for the S3 bucket |
| server_side_encryption_configuration_inputs | list(object()) | none | true | none |
| versioning_inputs | list(object()) | none | true | none |

## Outputs
Outputs include all the values that the module provides to other modules or solutions.

| Name             | Description   |
|------------------|---------------|
| bucket_arn | none |
| bucket_name | none |
| key_arn | none |
| key_name | none |

## Dependencies
All resources, modules and data sources which are external to this module are listed in this section. The module depends on them and any change in one or more of them may impact the module.

### Data Resources

| Data resource type | Data resource name | Data resource provider |
|--------------------|--------------------|------------------------|
| aws_region | current | aws |

### Resources

| Resource Type    | Resource Name    | Resource Provider |
|------------------|------------------|-------------------|
| aws_kms_alias | key_alias | aws |
| aws_kms_key | key | aws |
| aws_s3_bucket | main | aws |
| aws_s3_bucket_policy | bucket_policy | aws |

