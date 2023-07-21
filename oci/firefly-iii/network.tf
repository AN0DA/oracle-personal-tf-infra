# Define the Oracle Virtual Cloud Network (VCN)
resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.1.0.0/16"

  display_name = "vcn-firefly-iii"
}

# Define the subnet for the VM
resource "oci_core_subnet" "subnet" {
  compartment_id = var.compartment_ocid

  vcn_id       = oci_core_virtual_network.vcn.id
  cidr_block   = "10.1.20.0/24"
  display_name = "subnet-firefly-iii"

  security_list_ids = [oci_core_security_list.security_list.id]
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "ig-firefly-iii"
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "routetable-firefly-iii"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}


# Define the security list for the subnet
resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "testSecurityList"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }


  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}
