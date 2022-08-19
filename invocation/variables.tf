variable "region" {
  description = "Default region - eu-west-2."
  type        = string
  default     = "eu-west-2"
}

variable "prefix" {
  description = "Resource name prefix."
  type        = string
  default     = "ax"
}

variable "environment" {
  description = "Environment where the resource are deployed"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Resources common tags"
  type        = map(string)
  default = {
  }
}

variable "http_token" {
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2). Valid values include optional or required. Defaults to optional."
  default     = "required"
}