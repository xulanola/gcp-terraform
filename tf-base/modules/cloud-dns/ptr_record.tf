data "google_dns_managed_zone" "ptr" {
  project = "${var.project}"
  count   = "${var.fleet_size}"
  name    = "ptr-${element(split(".", element(split(",", var.ip_list), count.index)), 2)}-${element(split(".", element(split(",", var.ip_list), count.index)), 1)}-${element(split(".", element(split(",", var.ip_list), count.index)), 0)}-${var.environment}-${var.region}-${replace(var.domain, ".", "-")}"
}

# ----------------------------------------------------------------------------------
# DOCUMENTATION
# var.ip_list is expected to be a comma-separated list of IP addresses.
# element(split(",", var.ip_list), count.index) => pulls the IP from the current index count
# split(".", element(split(",", var.ip_list), count.index)) => splits the IP into an array of four numbers: [0] = first octet, [1] = second octet, [2] = third octet, and [3] = fourth octet
# element(split(".", element(split(",", var.ip_list), count.index)), 2)} => pulls the third octet, which is element[2]
# ----------------------------------------------------------------------------------
resource "google_dns_record_set" "ptr" {
  count        = "${var.fleet_size}"
  name         = "${element(split(".", element(split(",", var.ip_list), count.index)), 3)}.${element(data.google_dns_managed_zone.ptr.*.dns_name, count.index)}"
  managed_zone = "${element(data.google_dns_managed_zone.ptr.*.name, count.index)}"
  project      = "${var.project}"
  type         = "PTR"
  ttl          = 60
  rrdatas      = ["${var.application}${format("%03d", count.index + 1)}.${var.environment}-${var.region}-${var.domain}."]
}
