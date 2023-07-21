output "firefly_vm_ip_address" {
  value = module.firefly-iii.vm_ip_address
}


output "firefly_private_key_pem" {
  value     = module.firefly-iii.generated_private_key_pem
  sensitive = true
}
