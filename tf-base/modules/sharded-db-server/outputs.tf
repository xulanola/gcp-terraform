output "instances" {
  value = ["${google_compute_instance.sharded_db_servers.*.self_link}"]
}

output "ips" {
  value = ["${google_compute_instance.sharded_db_servers.*.network_interface.0.address}"]
}
