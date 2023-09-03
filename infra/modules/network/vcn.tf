resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.1.0.0/16"

  display_name = "vcn-base"
  dns_label    = "basevcn"
}
