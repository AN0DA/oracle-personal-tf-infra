resource "oci_kms_key" "firefly_vault_key" {
  compartment_id = var.compartment_ocid
  display_name   = "firefly_vault_key"
  key_shape {
    algorithm = "AES"
    length    = 24
  }
  management_endpoint = var.vault_management_endpoint
}

resource "oci_vault_secret" "vault_secret_admin_passwd" {
  compartment_id = var.compartment_ocid
  secret_name    = "firefly_db_admin_password"

  secret_content {
    content      = base64encode(random_password.admin_password.result)
    content_type = "BASE64"
  }

  vault_id = var.vault_id
  key_id   = oci_kms_key.firefly_vault_key.id
}

resource "oci_vault_secret" "vault_secret_wallet_passwd" {
  compartment_id = var.compartment_ocid
  secret_name    = "firefly_db_wallet_password"

  secret_content {
    content      = base64encode(random_password.wallet_password.result)
    content_type = "BASE64"
  }

  vault_id = var.vault_id
  key_id   = oci_kms_key.firefly_vault_key.id
}
