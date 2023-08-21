resource "oci_core_network_security_group" "base_network_security_group" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id

  display_name = "base_network_security_group"
}

resource "oci_core_network_security_group_security_rule" "network_security_group_security_rule_ssh" {
  network_security_group_id = oci_core_network_security_group.base_network_security_group.id
  description               = "ssh"
  direction                 = "INGRESS"
  protocol                  = 6
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
