terraform {
  source = "../../..//modules/load_balancer"
}

include {
  path = find_in_parent_folders("oci.hcl")
}


dependency "instance" {
  config_path = "../instance"
  mock_outputs = {
    vm_ip_address = "0.0.0.0",
  }
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    base_subnet_id    = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  }
}


inputs = {
  base_subnet_id     = dependency.network.outputs.base_subnet_id,
  instance_public_id = dependency.instance.outputs.vm_ip_address,
}
