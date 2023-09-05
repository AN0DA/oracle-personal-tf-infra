output "base_subnet_id" {
  value = oci_core_subnet.subnet_base.id
}

output "lb_subnet_id" {
  value = oci_core_subnet.subnet_load_balancer.id
}

output "db_subnet_id" {
  value = oci_core_subnet.subnet_db.id
}

output "sg_lb_id" {
  value = oci_core_network_security_group.LBSecurityGroup.id
}

output "sg_web_id" {
  value = oci_core_network_security_group.WebSecurityGroup.id
}

output "sg_ssh_id" {
  value = oci_core_network_security_group.SSHSecurityGroup.id
}

output "sg_db_id" {
  value = oci_core_network_security_group.DBSecurityGroup.id
}

output "vcn_id" {
  value = oci_core_virtual_network.vcn.id
}
