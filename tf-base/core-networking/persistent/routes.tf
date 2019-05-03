# ----------------------------------------------------------------------------------
# STUB FILE FOR ANY CUSTOM ROUTES
#
# ----------------------------------------------------------------------------------

resource "google_compute_route" "nonprod_shared_vpc_a_10_route" {
  dest_range  = "10.0.0.0/8"
  name        = "nonprod-shared-vpc-a-10-route"
  network     = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  priority    = "${var.companyX_route_priority["a-route"]}"
  project     = "${google_project.nonprod_shared_vpc.project_id}"
  next_hop_ip = "172.25.255.33"
}

//resource "google_compute_route" "nonprod_shared_vpc_b_10_route" {
//  dest_range = "10.0.0.0/8"
//  name = "nonprod-shared-vpc-b-10-route"
//  network = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
//  priority = "${var.companyX_route_priority["b-route"]}"
//  project = "${google_project.nonprod_shared_vpc.project_id}"
//  next_hop_ip = "172.25.255.33"
//}

resource "google_compute_route" "nonprod_shared_vpc_a_130_route" {
  dest_range  = "172.25.130.0/24"
  name        = "nonprod-shared-vpc-a-130-route"
  network     = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  priority    = "${var.companyX_route_priority["a-route"]}"
  project     = "${google_project.nonprod_shared_vpc.project_id}"
  next_hop_ip = "172.25.255.33"
}

//resource "google_compute_route" "nonprod_shared_vpc_b_130_route" {
//  dest_range = "172.25.130.0/24"
//  name = "nonprod-shared-vpc-b-130-route"
//  network = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
//  priority = "${var.companyX_route_priority["b-route"]}"
//  project = "${google_project.nonprod_shared_vpc.project_id}"
//  next_hop_ip = "172.25.255.33"
//}

resource "google_compute_route" "nonprod_shared_vpc_a_129_route" {
  dest_range  = "172.25.129.0/24"
  name        = "nonprod-shared-vpc-a-129-route"
  network     = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  priority    = "${var.companyX_route_priority["a-route"]}"
  project     = "${google_project.nonprod_shared_vpc.project_id}"
  next_hop_ip = "172.25.255.33"
}

//resource "google_compute_route" "nonprod_shared_vpc_b_129_route" {
//  dest_range = "172.25.129.0/24"
//  name = "nonprod-shared-vpc-b-129-route"
//  network = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
//  priority = "${var.companyX_route_priority["b-route"]}"
//  project = "${google_project.nonprod_shared_vpc.project_id}"
//  next_hop_ip = "172.25.255.33"
//}

