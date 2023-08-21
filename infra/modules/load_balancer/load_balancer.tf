resource "oci_load_balancer_load_balancer" "load_balancer" {
  compartment_id = var.compartment_ocid
  display_name   = "lb-firefly"
  shape          = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  subnet_ids = [var.base_subnet_id]
}

resource "oci_load_balancer_backend_set" "load_balancer_backend_set" {
  name             = "lb_backend_set-firefly"
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }

  session_persistence_configuration {
    cookie_name      = "lb-session-firefly"
    disable_fallback = true
  }
}

resource "oci_load_balancer_backend" "load_balancer_test_backend" {
  backendset_name  = oci_load_balancer_backend_set.load_balancer_backend_set.name
  ip_address       = var.instance_public_id
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

#resource "oci_load_balancer_listener" "load_balancer_listener_https" {
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
