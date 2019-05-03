# ----------------------------------------------------------------------------------
# NETWORK OUTPUTS
#
# ----------------------------------------------------------------------------------

output "prod_host_project_network" {
  value = "${google_compute_network.prod_shared_network.self_link}"
}

output "nonprod_host_project_network" {
  value = "${google_compute_network.nonprod_shared_network.self_link}"
}

output "dev_project_network" {
  value = "${google_compute_subnetwork.dev_vpc_subnetwork.self_link}"
}
