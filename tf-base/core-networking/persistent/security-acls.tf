# ----------------------------------------------------------------------------------
# FIREWALL RULES
# Allow the hosted network to be hit over ICMP, SSH, and HTTP.
# ----------------------------------------------------------------------------------

resource "google_compute_firewall" "prod_shared_network" {
  name    = "allow-ssh-and-icmp"
  network = "${google_compute_network.prod_shared_vpc_network.self_link}"
  project = "${google_compute_network.prod_shared_vpc_network.project}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "1194"]
  }

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
}

resource "google_compute_firewall" "nonprod_shared_network" {
  name    = "allow-ssh-and-icmp"
  network = "${google_compute_network.nonprod_shared_vpc_network.self_link}"
  project = "${google_compute_network.nonprod_shared_vpc_network.project}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "1194"]
  }

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
}
