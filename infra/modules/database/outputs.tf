output "db_private_ip" {
  value = oci_core_instance.db_instance.private_ip
}

output "db_private_key" {
  value     = tls_private_key.compute_ssh_key.private_key_pem
  sensitive = true
}

output "bastion_private_key" {
  value     = tls_private_key.bastion_ssh_key.private_key_pem
  sensitive = true
}

output "bastion_session_username" {
  value = oci_bastion_session.db_bastionsession.id
}
