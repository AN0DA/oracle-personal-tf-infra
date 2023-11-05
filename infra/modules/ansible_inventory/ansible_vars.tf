resource "local_sensitive_file" "role_firefly_iii_variables" {
  content = <<EOT
---
db_private_ip: ${var.db_instance_private_id}
firefly_db_user_password: ${var.firefly_db_user_password}
  EOT

  filename = "${var.playbooks_path}/roles/firefly_iii/vars/main.yml"
}

resource "local_sensitive_file" "role_mysql_variables" {
  content = <<EOT
---
firefly_db_user_password: ${var.firefly_db_user_password}
db_root_password: ${var.db_root_password}

backup_bucket_name: ${var.backup_bucket_name}
backup_bucket_namespace: ${var.backup_bucket_namespace}
  EOT

  filename = "${var.playbooks_path}/roles/mysql/vars/main.yml"
}

resource "local_sensitive_file" "role_newrelic_variables" {
  content = <<EOT
---
db_root_password: ${var.db_root_password}
  EOT

  filename = "${var.playbooks_path}/roles/newrelic/vars/main.yml"
}

resource "local_sensitive_file" "role_oci_cli_variables" {
  content = <<EOT
---
tenancy_ocid: ${var.tenancy_ocid}
user_ocid: ${var.user_ocid}
fingerprint: ${var.fingerprint}

key_file_path: ${var.private_key_path}

  EOT

  filename = "${var.playbooks_path}/roles/oci_cli/vars/main.yml"
}