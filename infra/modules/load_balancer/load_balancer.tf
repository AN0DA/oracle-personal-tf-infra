resource "oci_load_balancer" "load_balancer" {
  compartment_id = var.compartment_ocid
  display_name   = "lb-firefly"
  shape          = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  subnet_ids                 = [var.lb_subnet_id]
  network_security_group_ids = [var.lb_sg_id]
}

resource "oci_load_balancer_backend_set" "load_balancer_backend_set" {
  name             = "lb_backend_set-firefly"
  load_balancer_id = oci_load_balancer.load_balancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/server-status"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_backend" "lb-backend" {
  load_balancer_id = oci_load_balancer.load_balancer.id
  backendset_name  = oci_load_balancer_backend_set.load_balancer_backend_set.name
  ip_address       = var.instance_private_id
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_listener" "lb-listener" {
  load_balancer_id         = oci_load_balancer.load_balancer.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.load_balancer_backend_set.name
  port                     = 80
  protocol                 = "HTTP"
}
