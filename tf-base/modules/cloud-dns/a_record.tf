# ----------------------------------------------------------------------------------
# DOCUMENTATION
# var.domain is expected to be companyXint.io, so the replace operation will turn companyXint.io into companyXint-io
# ----------------------------------------------------------------------------------

data "google_dns_managed_zone" "a" {
  project = "${var.project}"
  name    = "${var.environment}-${var.region}-${replace(var.domain, ".", "-")}"
}

resource "google_dns_record_set" "a" {
  count        = "${var.fleet_size}"
  name         = "${var.application}${format("%03d", count.index + 1)}.${data.google_dns_managed_zone.a.dns_name}"
  managed_zone = "${data.google_dns_managed_zone.a.name}"
  project      = "${var.project}"
  type         = "A"
  ttl          = 60
  rrdatas      = ["${element(split(",", var.ip_list), count.index)}"]
}
