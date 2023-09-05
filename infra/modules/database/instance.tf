resource "oci_core_instance" "db_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "firefly_db"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.db_subnet_id
    assign_public_ip = false
    nsg_ids          = [var.sg_db_id, var.sg_ssh_id]
  }

  agent_config {
    plugins_config {
      desired_state = "ENABLED"
      name          = "Bastion"
    }
  }

  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.test_images.images[0], "id")
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.compute_ssh_key.public_key_openssh
  }
}
