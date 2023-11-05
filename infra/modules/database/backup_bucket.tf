resource "oci_objectstorage_bucket" "backup_bucket" {
  name           = "db_backup"
  compartment_id = var.compartment_ocid
  namespace      = data.oci_objectstorage_namespace.namespace.namespace
}
