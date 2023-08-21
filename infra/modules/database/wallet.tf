resource "oci_database_autonomous_database_wallet" "firefly_wallet" {
  autonomous_database_id = oci_database_autonomous_database.firefly_database.id
  password               = random_password.wallet_password.result
}

resource "local_sensitive_file" "firefly_wallet_zip" {
  content  = oci_database_autonomous_database_wallet.firefly_wallet.content
  filename = "firefly_wallet.zip"
}


resource "oci_objectstorage_bucket" "firefly_wallet" {
  compartment_id = var.compartment_ocid
  name           = "firefly_wallet"
  namespace      = data.oci_objectstorage_namespace.namespace.namespace
}

resource "oci_objectstorage_object" "firefly_wallet_object" {
  bucket    = oci_objectstorage_bucket.firefly_wallet.name
  namespace = data.oci_objectstorage_namespace.namespace.namespace
  object    = "firefly_wallet.zip"
}
