output "vm_public_ip" {
  value = oci_core_instance.vm_instance.public_ip
}

output "vm_private_ip" {
  value = oci_core_instance.vm_instance.private_ip
}


output "generated_private_key_pem" {
  value     = tls_private_key.compute_ssh_key.private_key_pem
  sensitive = true
}
