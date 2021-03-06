###
## Site to Site VPN Infrastructure
#

resource "google_compute_vpn_gateway" "prod_a_target_gateway" {
  name    = "prod-shared-vpc-a-vpn"
  network = "${google_compute_network.prod_shared_vpc_network.self_link}"
  region  = "${element(var.region, 0)}"
  project = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_vpn_gateway" "prod_b_target_gateway" {
  name    = "prod-shared-vpc-b-vpn"
  network = "${google_compute_network.prod_shared_vpc_network.self_link}"
  region  = "${element(var.region, 0)}"
  project = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_address" "prod_a_vpn_static_ip" {
  name    = "vpn-prod-shared-vpc-a-ip"
  region  = "${element(var.region, 0)}"
  project = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_address" "prod_b_vpn_static_ip" {
  name    = "vpn-prod-shared-vpc-b-ip"
  region  = "${element(var.region, 0)}"
  project = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_forwarding_rule" "prod_a_fr_esp" {
  name        = "prod-a-fr-esp"
  region      = "${element(var.region, 0)}"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.prod_a_vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.prod_a_target_gateway.self_link}"
  project     = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_forwarding_rule" "prod_a_fr_udp_500" {
  name        = "prod-a-fr-udp-500"
  region      = "${element(var.region, 0)}"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.prod_a_vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.prod_a_target_gateway.self_link}"
  project     = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_forwarding_rule" "prod_a_fr_udp_4500" {
  name        = "prod-a-fr-udp-4500"
  region      = "${element(var.region, 0)}"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.prod_a_vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.prod_a_target_gateway.self_link}"
  project     = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_forwarding_rule" "prod_b_fr_esp" {
  name        = "prod-b-fr-esp"
  region      = "${element(var.region, 0)}"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.prod_b_vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.prod_b_target_gateway.self_link}"
  project     = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_forwarding_rule" "prod_b_fr_udp_500" {
  name        = "prod-b-fr-udp-500"
  region      = "${element(var.region, 0)}"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.prod_b_vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.prod_b_target_gateway.self_link}"
  project     = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_forwarding_rule" "prod_b_fr_udp_4500" {
  name        = "prod-b-fr-udp-4500"
  region      = "${element(var.region, 0)}"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.prod_b_vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.prod_b_target_gateway.self_link}"
  project     = "${google_project.prod_shared_vpc.project_id}"
}

# ----------------------------------------------------------------------------------
# VPN TUNNEL CONFIGURATION
#
# ----------------------------------------------------------------------------------

###
## companyX Datacenter VPN A Tunnel Definition
#
resource "google_compute_vpn_tunnel" "prod_vpn_a_tunnel" {
  name          = "prod-shared-vpc-companyX-a-tunnel"
  region        = "${element(var.region, 0)}"
  project       = "${google_project.prod_shared_vpc.project_id}"
  peer_ip       = "${var.companyX_peer_ip["west"]}"
  shared_secret = "9rZuF7pILhOFrxAFU5QOo9ggVTalTyMu"
  ike_version   = "1"

  # @TODO move this to a secret
  target_vpn_gateway = "${google_compute_vpn_gateway.prod_a_target_gateway.self_link}"

  local_traffic_selector = [
    "0.0.0.0/0",
  ]

  remote_traffic_selector = [
    "0.0.0.0/0",
  ]

  depends_on = [
    "google_compute_forwarding_rule.prod_a_fr_esp",
    "google_compute_forwarding_rule.prod_a_fr_udp_500",
    "google_compute_forwarding_rule.prod_a_fr_udp_4500",
  ]
}

resource "google_compute_route" "prod_vpc_a_route" {
  name                = "prod-shared-vpc-companyX-a-tunnel-route"
  network             = "${google_compute_network.prod_shared_vpc_network.self_link}"
  project             = "${google_project.prod_shared_vpc.project_id}"
  dest_range          = "${var.companyX_supernet["prod"]}"
  priority            = "${var.companyX_route_priority["a-route"]}"
  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.prod_vpn_a_tunnel.self_link}"
}

###
## Second Tunnel
#

resource "google_compute_vpn_tunnel" "prod_vpn_b_tunnel" {
  name          = "prod-shared-vpc-companyX-b-tunnel"
  region        = "${element(var.region, 0)}"
  project       = "${google_project.prod_shared_vpc.project_id}"
  peer_ip       = "${var.companyX_peer_ip["west"]}"
  shared_secret = "9rZuF7pILhOFrxAFU5QOo9ggVTalTyMu"
  ike_version   = "1"

  # @TODO move this to a secret
  target_vpn_gateway = "${google_compute_vpn_gateway.prod_b_target_gateway.self_link}"

  local_traffic_selector = [
    "0.0.0.0/0",
  ]

  remote_traffic_selector = [
    "0.0.0.0/0",
  ]

  depends_on = [
    "google_compute_forwarding_rule.prod_b_fr_esp",
    "google_compute_forwarding_rule.prod_b_fr_udp_500",
    "google_compute_forwarding_rule.prod_b_fr_udp_4500",
  ]
}

resource "google_compute_route" "prod_vpc_b_route" {
  name                = "prod-shared-vpc-companyX-b-tunnel-route"
  network             = "${google_compute_network.prod_shared_vpc_network.self_link}"
  project             = "${google_project.prod_shared_vpc.project_id}"
  dest_range          = "${var.companyX_supernet["prod"]}"
  priority            = "${var.companyX_route_priority["b-route"]}"
  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.prod_vpn_b_tunnel.self_link}"
}
