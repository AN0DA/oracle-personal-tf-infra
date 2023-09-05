resource "oci_core_nat_gateway" "nat_gw" {
  compartment_id = var.compartment_ocid
  display_name   = "nat_gateway"
  vcn_id         = oci_core_virtual_network.vcn.id
}
