terraform {
  source = "../../..//modules/instance"

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

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    base_subnet_id = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    vcn_id = "ocid1.vcn.oc1.eu-amsterdam-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  }
}


inputs = {
  base_subnet_id = dependency.network.outputs.base_subnet_id,
  vcn_id = dependency.network.outputs.vcn_id,
}
