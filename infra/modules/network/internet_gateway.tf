resource "oci_core_internet_gateway" "internet_gateway_base" {
  compartment_id = var.compartment_ocid
  display_name   = "ig-base"
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "route_table_base" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "routetable-base"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway_base.id
  }
}