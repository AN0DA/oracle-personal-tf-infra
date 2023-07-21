resource "oci_core_instance" "vm_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "vm-firefly-iii"
  shape               = var.instance_shape

  shape_config {
    ocpus         = 2
    memory_in_gbs = 8
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    #    source_id   = lookup(data.oci_core_images.test_images.images[0], "id")
    source_id   = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaaogxjhdac7hpwvdiwlzsm2rbt4kuzmbczpt4oryi4iqpq4jqnwifq"
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.compute_ssh_key.public_key_openssh
  }
}

resource "tls_private_key" "compute_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


/* Load Balancer */

resource "oci_load_balancer_load_balancer" "load_balancer" {
  compartment_id = var.compartment_ocid
  display_name   = "lb-firefly-iii"
  shape          = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  subnet_ids = [
    oci_core_subnet.subnet.id,
  ]
}

resource "oci_load_balancer_backend_set" "load_balancer_backend_set" {
  name             = "lb_backend_set-firefly-iii"
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }

  session_persistence_configuration {
    cookie_name      = "lb-session-firefly-iii"
    disable_fallback = true
  }
}

resource "oci_load_balancer_backend" "load_balancer_test_backend" {
  backendset_name  = oci_load_balancer_backend_set.load_balancer_backend_set.name
  ip_address       = oci_core_instance.vm_instance.public_ip
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  port             = "80"
}


resource "oci_load_balancer_hostname" "hostname" {
  hostname         = "mkaczmarek.com"
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  name             = "mkaczmarek"
}

resource "oci_load_balancer_listener" "load_balancer_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.load_balancer_backend_set.name
  hostname_names           = [oci_load_balancer_hostname.hostname.name]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "240"
  }
}

resource "tls_private_key" "example" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    organization = "Oracle"
    country      = "US"
    locality     = "Austin"
    province     = "TX"
  }

  validity_period_hours = 8760 # 1 year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]

  is_ca_certificate = true
}

resource "oci_load_balancer_certificate" "load_balancer_certificate" {
  load_balancer_id   = oci_load_balancer_load_balancer.load_balancer.id
  ca_certificate     = tls_self_signed_cert.example.cert_pem
  certificate_name   = "certificate1"
  private_key        = tls_private_key.example.private_key_pem
  public_certificate = tls_self_signed_cert.example.cert_pem

  lifecycle {
    create_before_destroy = true
  }
}

#resource "oci_load_balancer_listener" "load_balancer_listener" {
#  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer.id
#  name                     = "https"
#  default_backend_set_name = oci_load_balancer_backend_set.load_balancer_backend_set.name
#  port                     = 443
#  protocol                 = "HTTP"
#
#  ssl_configuration {
#    certificate_name        = oci_load_balancer_certificate.load_balancer_certificate.certificate_name
#    verify_peer_certificate = false
#  }
#}
