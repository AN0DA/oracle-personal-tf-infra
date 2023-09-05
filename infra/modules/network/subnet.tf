resource "oci_core_subnet" "subnet_base" {
  compartment_id = var.compartment_ocid

  vcn_id       = oci_core_virtual_network.vcn.id
  cidr_block   = "10.1.0.0/24"
  display_name = "subnet-base"
  dns_label    = "basesubnet"

  dhcp_options_id = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-pub.id
}

resource "oci_core_subnet" "subnet_load_balancer" {
  compartment_id = var.compartment_ocid

  vcn_id       = oci_core_virtual_network.vcn.id
  cidr_block   = "10.1.1.0/24"
  display_name = "subnet-lb"
  dns_label    = "lbsubnet"

  dhcp_options_id = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-pub.id
}

resource "oci_core_subnet" "subnet_db" {
  compartment_id = var.compartment_ocid

  vcn_id       = oci_core_virtual_network.vcn.id
  cidr_block   = "10.1.2.0/24"
  display_name = "subnet-db"
  dns_label    = "dbsubnet"

  dhcp_options_id = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-priv.id
}