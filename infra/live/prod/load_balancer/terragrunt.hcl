terraform {
  source = "../../..//modules/load_balancer"
}

include {
  path = find_in_parent_folders("oci.hcl")
}


dependency "instance" {
  config_path = "../instance"
  mock_outputs = {
    vm_private_ip = "0.0.0.0",
  }
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    lb_subnet_id = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    sg_lb_id     = "ocid1.networksecuritygroup.oc1.eu-amsterdam-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  }
}


inputs = {
  lb_subnet_id        = dependency.network.outputs.lb_subnet_id,
  lb_sg_id            = dependency.network.outputs.sg_lb_id,
  instance_private_id = dependency.instance.outputs.vm_private_ip,
}
