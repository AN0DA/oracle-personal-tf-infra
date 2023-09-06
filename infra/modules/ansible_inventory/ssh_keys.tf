resource "local_file" "base_instance_private_key" {
  content         = var.base_instance_private_key
  filename        = "${var.playbooks_path}/ssh_keys/firefly.pem"
  file_permission = "400"
}

resource "local_file" "db_instance_private_key" {
  content         = var.db_instance_private_key
  filename        = "${var.playbooks_path}/ssh_keys/firefly_db.pem"
  file_permission = "400"
}

resource "local_file" "db_bastion_private_key" {
  content         = var.db_bastion_private_key
  filename        = "${var.playbooks_path}/ssh_keys/firefly_db_bastion.pem"
  file_permission = "400"
}
