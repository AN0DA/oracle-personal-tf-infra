data "cloudflare_zone" "mkaczmarek" {
  name = "mkaczmarek.com"
}


resource "cloudflare_record" "dns" {
  for_each = toset(["@", "firefly", "importer"])

  zone_id = data.cloudflare_zone.mkaczmarek.id
  name    = each.key
  value   = oci_load_balancer.load_balancer.ip_address_details[0].ip_address
  type    = "A"
  proxied = true
}
