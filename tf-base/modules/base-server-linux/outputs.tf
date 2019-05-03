output "instances" {
  value = ["${google_compute_instance.hosts.*.self_link}"]
}

output "ips" {
  value = ["${google_compute_instance.hosts.*.network_interface.0.address}"]
}
