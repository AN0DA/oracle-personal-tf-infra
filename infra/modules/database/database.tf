resource "oci_database_autonomous_database" "firefly_database" {
  admin_password = random_password.admin_password.result
  compartment_id = var.compartment_ocid

  db_name = "firefly"

  db_workload  = "OLTP"
  display_name = "firefly"

  freeform_tags = {
    "Application" = "firefly"
  }

  is_auto_scaling_enabled = "false"
  license_model           = "LICENSE_INCLUDED"
  is_free_tier            = "true"
}
