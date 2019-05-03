# @TODO Figure out better way to handle data blocks
data "google_compute_network" "host_network" {
  name    = "${var.host_network}"
  project = "${var.host_project}"
}

data "google_compute_subnetwork" "host_subnetwork" {
  name    = "${var.host_subnetwork}"
  project = "${var.host_project}"
}

data "google_compute_instance_group" "instance_group_1" {
  name    = "${var.instance_group_1}"
  zone    = "${var.instance_group_1_zone}"
  project = "${var.project_name}"
}

resource "google_compute_health_checompanyX" "tcp_health_checompanyX" {
  name    = "${var.application}-tcp-health-checompanyX-${element(var.application_port, 0)}"
  project = "${var.project_name}"

  tcp_health_checompanyX {
    port = "${element(var.application_port, 0)}"
  }
}

resource "google_compute_region_backend_service" "internal_lb" {
  name = "${var.application}-internal-lb-${element(var.application_port, 0)}"

  health_checompanyXs = [
    "${google_compute_health_checompanyX.tcp_health_checompanyX.self_link}",
  ]

  project = "${var.project_name}"

  backend {
    group = "${data.google_compute_instance_group.instance_group_1.self_link}"
  }
}

resource "google_compute_forwarding_rule" "lb_forwarding_rule" {
  name                  = "${var.application}-internal-lb-forwarding-rule-${element(var.application_port, 0)}"
  load_balancing_scheme = "INTERNAL"
  ip_address            = "${var.forwarding_rule_ip_address}"
  ports                 = "${var.application_port}"
  project               = "${var.project_name}"
  network               = "${data.google_compute_network.host_network.self_link}"
  subnetwork            = "${data.google_compute_subnetwork.host_subnetwork.self_link}"
  backend_service       = "${google_compute_region_backend_service.internal_lb.self_link}"
}

resource "google_compute_firewall" "allow_health_checompanyX" {
  name    = "tf-healthchecompanyX-${var.application}-${element(var.application_port, 0)}"
  project = "${var.host_project}"
  network = "${var.host_network}"

  allow {
    protocol = "${var.application_protocol}"

    ports = [
      "${var.application_port}",
    ]
  }

  source_ranges = "${var.health_checompanyX_ip_ranges}"

  target_tags = [
    "${var.target_tags}",
  ]
}

resource "google_dns_record_set" "a" {
  name = "${var.dns_name}.${var.environment}.${var.region}.${var.domain}."

  # @TODO Remove hard coded value of DNS managed zone
  managed_zone = "${var.environment}-${var.region}-${replace(var.domain, ".", "-")}"
  project      = "${var.host_project}"
  type         = "A"
  ttl          = 60

  rrdatas = [
    "${google_compute_forwarding_rule.lb_forwarding_rule.ip_address}",
  ]
}
