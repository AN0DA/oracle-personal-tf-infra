resource "random_password" "db_user_password" {
  length           = 24
  special          = true
  override_special = "\"'"
}
