resource "oci_database_autonomous_database" "database" {
  admin_password           = "Testalwaysfree1"
  compartment_id           = var.compartment_ocid
  cpu_core_count           = "1"
  data_storage_size_in_tbs = "1"
  db_name                  = "firefly"

  db_workload  = "OLTP"
  display_name = "firefly-iii"

  freeform_tags = {
    "Application" = "firefly-iii"
  }

  is_auto_scaling_enabled = "false"
  license_model           = "LICENSE_INCLUDED"
  is_free_tier            = "true"
}
