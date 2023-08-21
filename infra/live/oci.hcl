locals {
  stack_name = "oracle-personal-tf-infra"
  env        = split("/", path_relative_to_include())[0]

  namespace    = get_env("TF_STATE_BUCKET_NAMESPACE")
  infra_region = "eu-amsterdam-1"
  state_bucket = "tf-infra-state"
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    endpoint = "https://${local.namespace}.compat.objectstorage.${local.infra_region}.oraclecloud.com"
    region   = local.infra_region
    bucket   = local.state_bucket
    key      = "${path_relative_to_include()}/terraform.tfstate"

    # All S3-specific validations are skipped:
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
    force_path_style        = true
  }
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.1.6"

  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}

provider "oci" {
  region           = "eu-amsterdam-1"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}
EOF
}


inputs = {
  env     = local.env
  project = local.stack_name
}

skip = true
