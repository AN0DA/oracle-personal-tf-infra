output "base_subnet_id" {
  value = oci_core_subnet.subnet_base.id
}

output "vcn_id" {
  value = oci_core_virtual_network.vcn.id
}
