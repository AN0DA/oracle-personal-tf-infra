resource "oci_bastion_bastion" "db_bastion" {

  bastion_type     = "STANDARD"
  compartment_id   = var.compartment_ocid
  target_subnet_id = var.db_subnet_id

  client_cidr_block_allow_list = ["0.0.0.0/0"]

  name = "db_bastion"
}

resource "oci_bastion_session" "db_bastionsession" {
  depends_on = [oci_bastion_bastion.db_bastion, oci_core_instance.db_instance]

  bastion_id = oci_bastion_bastion.db_bastion.id

  key_details {
    public_key_content = tls_private_key.bastion_ssh_key.public_key_openssh
  }

  target_resource_details {

    session_type       = "MANAGED_SSH"
    target_resource_id = time_sleep.db_instance_id.triggers["db_instance_id"]

    target_resource_operating_system_user_name = "ubuntu"
    target_resource_port                       = "22"
  }

  session_ttl_in_seconds = 10800

  display_name = "bastionsession-db-instance"
}


resource "time_sleep" "db_instance_id" {
  create_duration = "90s"

  triggers = {
    db_instance_id = oci_core_instance.db_instance.id
  }
}