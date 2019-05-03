output "instances" {
  value = ["${google_compute_instance.db_servers.*.self_link}"]
}
