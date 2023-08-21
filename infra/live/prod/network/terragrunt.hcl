terraform {
  source = "../../..//modules/network"
}

include {
  path = find_in_parent_folders("oci.hcl")
}
