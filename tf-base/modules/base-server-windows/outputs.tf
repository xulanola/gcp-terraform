output "instances" {
  value = ["${google_compute_instance.windows_hosts.*.self_link}"]
}

output "ips" {
  value = ["${google_compute_instance.windows_hosts.*.network_interface.0.address}"]
}
