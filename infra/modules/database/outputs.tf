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

output "firefly_db_user_password" {
  value     = random_password.firefly_db_user_password.result
  sensitive = true
}

output "db_root_password" {
  value     = random_password.db_root_password.result
  sensitive = true
}

output "backup_bucket_name" {
  value = oci_objectstorage_bucket.backup_bucket.name
}

output "backup_bucket_namespace" {
  value = data.oci_objectstorage_namespace.namespace.namespace
}