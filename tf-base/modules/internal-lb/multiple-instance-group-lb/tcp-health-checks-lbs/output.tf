output "internal_load_balancer_ip_address" {
  value = "${google_dns_record_set.a.name}"
}
