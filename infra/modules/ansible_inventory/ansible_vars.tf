resource "local_sensitive_file" "role_firefly_iii_variables" {
  content = <<EOT
---
db_private_ip: ${var.db_instance_private_id}
db_user_password: ${var.db_user_password}
  EOT

  filename = "${var.playbooks_path}/roles/firefly_iii/vars/main.yml"
}

resource "local_sensitive_file" "role_mysql_variables" {
  content = <<EOT
---
db_user_password: ${var.db_user_password}
db_root_password: ${var.db_root_password}
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