resource "local_file" "inventory" {
  depends_on = [local_file.base_instance_private_key, local_file.db_instance_private_key, local_file.db_bastion_private_key]

  content = <<EOT
[base_instance]
${var.base_instance_public_ip} ansible_public_ip=${var.base_instance_public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${local_file.base_instance_private_key.filename}

[db_instance]
${var.db_instance_private_id} ansible_host=${var.db_instance_private_id} ansible_user=ubuntu ansible_ssh_private_key_file=${local_file.db_instance_private_key.filename} ansible_ssh_common_args='-o ProxyCommand="ssh -i ${local_file.db_bastion_private_key.filename} -W %h:%p -p 22 ${var.db_bastion_username}@host.bastion.eu-amsterdam-1.oci.oraclecloud.com"'
  EOT

  filename = "${var.playbooks_path}/inventory.ini"
}