resource "random_password" "db_user_password" {
  length           = 24

  special          = true
  override_special = "\"'"

    min_lower = 1
  min_upper = 1
  min_numeric = 1
  min_special = 1
}

resource "random_password" "db_root_password" {
  length           = 24

    special          = true
  override_special = "\"'"

  min_lower = 1
  min_upper = 1
  min_numeric = 1
  min_special = 1
}
