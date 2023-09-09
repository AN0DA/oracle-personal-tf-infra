terraform {
  source = "../../..//modules/ansible_inventory"
}

include {
  path = find_in_parent_folders("oci.hcl")
}

dependency "instance" {
  config_path = "../instance"
  mock_outputs = {
    vm_public_ip              = "0.0.0.0",
    generated_private_key_pem = "",
  }
}

dependency "database" {
  config_path = "../database"
  mock_outputs = {
    db_private_ip            = "0.0.0.0",
    db_private_key           = "",
    bastion_session_username = "ocid1.bastionsession.oc1.eu-amsterdam-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    bastion_private_key      = "",
    db_user_password         = "xxxxxxxxxxxxxxxxxxxxxxxx"
    db_root_password         = "xxxxxxxxxxxxxxxxxxxxxxxx"
  }
}


inputs = {
  base_instance_public_ip   = dependency.instance.outputs.vm_public_ip,
  base_instance_private_key = dependency.instance.outputs.generated_private_key_pem,
  db_instance_private_id    = dependency.database.outputs.db_private_ip,
  db_instance_private_key   = dependency.database.outputs.db_private_key,
  db_bastion_username       = dependency.database.outputs.bastion_session_username,
  db_bastion_private_key    = dependency.database.outputs.bastion_private_key,
  db_user_password          = dependency.database.outputs.db_user_password,
  db_root_password          = dependency.database.outputs.db_root_password,
  playbooks_path            = "${get_repo_root()}/playbooks"
}
