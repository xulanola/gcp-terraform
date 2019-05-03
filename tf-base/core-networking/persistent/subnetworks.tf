resource "google_compute_network" "prod_shared_vpc_network" {
  name                    = "prod-shared-vpc-network-172-26-0-0-16"
  project                 = "${google_compute_shared_vpc_host_project.prod_host_project.id}"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "nonprod_shared_vpc_network" {
  name                    = "nonprod-shared-vpc-network-172-26-0-0-16"
  project                 = "${google_compute_shared_vpc_host_project.nonprod_host_project.id}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "dev_vpc_subnetwork" {
  name                     = "dev-172-25-0-0-24"
  network                  = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  project                  = "${google_compute_shared_vpc_host_project.nonprod_host_project.project}"
  region                   = "${element(var.region, 0)}"
  ip_cidr_range            = "172.25.0.0/24"
  private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "nonprod_vpn_subnetwork" {
  name                     = "nonprod-vpn-172-25-255-32-27"
  network                  = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  project                  = "${google_compute_shared_vpc_host_project.nonprod_host_project.project}"
  region                   = "${element(var.region, 0)}"
  ip_cidr_range            = "172.25.255.32/27"
  private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "nonprod_natgw_subnetwork" {
  name                     = "nonprod-natgw-172-25-255-0-27"
  network                  = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  project                  = "${google_compute_shared_vpc_host_project.nonprod_host_project.project}"
  region                   = "${element(var.region, 0)}"
  ip_cidr_range            = "172.25.255.0/27"
  private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "nonprod_shared_services_subnetwork" {
  name                     = "nonprod-shared-svcs-172-25-254-0-24"
  network                  = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  project                  = "${google_compute_shared_vpc_host_project.nonprod_host_project.project}"
  region                   = "${element(var.region, 0)}"
  ip_cidr_range            = "172.25.254.0/24"
  private_ip_google_access = "true"
}
