data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

#data "oci_core_images" "test_images" {
#  compartment_id           = var.compartment_ocid
#  operating_system         = "Oracle Linux"
#  operating_system_version = "9"
#  #shape                    = var.instance_shape
#  sort_by    = "TIMECREATED"
#  sort_order = "DESC"
#}
