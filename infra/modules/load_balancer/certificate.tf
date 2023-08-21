resource "tls_private_key" "tls_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "tls_cert" {
  private_key_pem = tls_private_key.tls_key.private_key_pem

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
  ca_certificate     = tls_self_signed_cert.tls_cert.cert_pem
  certificate_name   = "mkaczmarek"
  private_key        = tls_private_key.tls_key.private_key_pem
  public_certificate = tls_self_signed_cert.tls_cert.cert_pem

  lifecycle {
    create_before_destroy = true
  }
}
