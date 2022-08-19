data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

data "aws_organizations_organization" "example" {}

output "account_ids" {
  value = data.aws_organizations_organization.example.accounts[*].id
}