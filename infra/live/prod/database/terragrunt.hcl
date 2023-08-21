terraform {
  source = "../../..//modules/database"

  extra_arguments "tfvars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/config.tfvars",
    ]
  }
}

include {
  path = find_in_parent_folders("oci.hcl")
}
