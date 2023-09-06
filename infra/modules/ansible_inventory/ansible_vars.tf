resource "local_sensitive_file" "db_variables" {
  content = <<EOT
---
db_private_ip: ${var.db_instance_private_id}
db_user_password: ${var.db_user_password}
  EOT

  filename = "${var.playbooks_path}/variables/db.yml"
}