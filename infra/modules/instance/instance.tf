resource "oci_core_instance" "vm_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "base_vm"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.base_subnet_id
    display_name     = "primaryvnic"
    assign_public_ip = true
    nsg_ids          = [oci_core_network_security_group.base_network_security_group.id]
  }


  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.test_images.images[0], "id")
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.compute_ssh_key.public_key_openssh
  }
}
