provider "random" {}

resource "random_password" "admin_password" {
  length  = 24
  special = true
}

resource "random_password" "wallet_password" {
  length  = 24
  special = true
}
