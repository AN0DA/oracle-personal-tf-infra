module "firefly-iii" {
  source = "./firefly-iii"

  compartment_ocid = var.compartment_ocid
  tenancy_ocid     = var.tenancy_ocid
}
