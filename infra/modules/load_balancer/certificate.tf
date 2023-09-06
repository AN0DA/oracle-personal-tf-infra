data "http" "ca_certificate" {
  method = "GET"
  url    = acme_certificate.certificate.certificate_url
}


resource "oci_load_balancer_certificate" "load_balancer_certificate" {
  load_balancer_id   = oci_load_balancer.load_balancer.id
  certificate_name   = "mkaczmarek"
  private_key        = acme_certificate.certificate.private_key_pem
  public_certificate = acme_certificate.certificate.certificate_pem
  ca_certificate     = data.http.ca_certificate.response_body
}
