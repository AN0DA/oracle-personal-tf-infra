resource "oci_core_subnet" "subnet_base" {
  compartment_id = var.compartment_ocid

  vcn_id       = oci_core_virtual_network.vcn.id
  cidr_block   = "10.1.20.0/24"
  display_name = "subnet-base"

  security_list_ids = [oci_core_security_list.security_list_base.id]
}
