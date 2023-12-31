## Copyright © 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# ATPSecurityGroup
resource "oci_core_network_security_group" "DBSecurityGroup" {
  compartment_id = var.compartment_ocid
  display_name   = "DBSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn.id

}

# Rules related to ATPSecurityGroup
# EGRESS
resource "oci_core_network_security_group_security_rule" "DBSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.DBSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.1.0.0/24"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "DBSecurityIngressGroupRules" {
  network_security_group_id = oci_core_network_security_group.DBSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.1.0.0/24"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 3306
      min = 3306
    }
  }
}

# WebSecurityGroup
resource "oci_core_network_security_group" "WebSecurityGroup" {
  compartment_id = var.compartment_ocid
  display_name   = "WebSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn.id

}
# Rules related to WebSecurityGroup
# EGRESS
resource "oci_core_network_security_group_security_rule" "WebSecurityEgressDBGroupRule" {
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.DBSecurityGroup.id
  destination_type          = "NETWORK_SECURITY_GROUP"
}
resource "oci_core_network_security_group_security_rule" "WebSecurityEgressInternetGroupRule" {
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.1.1.0/24"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "WebSecurityIngressGroupRules-http" {
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.1.1.0/24"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}
#
#resource "oci_core_network_security_group_security_rule" "WebSecurityIngressGroupRules-https" {
#  network_security_group_id = oci_core_network_security_group.WebSecurityGroup.id
#  direction                 = "INGRESS"
#  protocol                  = "6"
#  source                    = "10.1.1.0/24"
#  source_type               = "CIDR_BLOCK"
#  tcp_options {
#    destination_port_range {
#      max = 443
#      min = 443
#    }
#  }
#}

# LBSecurityGroup
resource "oci_core_network_security_group" "LBSecurityGroup" {
  compartment_id = var.compartment_ocid
  display_name   = "LBSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn.id

}
# Rules related to LBSecurityGroup
# EGRESS
resource "oci_core_network_security_group_security_rule" "LBSecurityEgressInternetGroupRule" {
  network_security_group_id = oci_core_network_security_group.LBSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "LBSecurityIngressGroupRules-http" {
  network_security_group_id = oci_core_network_security_group.LBSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "LBSecurityIngressGroupRules-https" {
  network_security_group_id = oci_core_network_security_group.LBSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 443
      min = 443
    }
  }
}

# SSHSecurityGroup
resource "oci_core_network_security_group" "SSHSecurityGroup" {
  compartment_id = var.compartment_ocid
  display_name   = "SSHSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn.id

}
# Rules related to SSHSecurityGroup
# EGRESS
resource "oci_core_network_security_group_security_rule" "SSHSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.SSHSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "SSHSecurityIngressGroupRules" {
  network_security_group_id = oci_core_network_security_group.SSHSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}
