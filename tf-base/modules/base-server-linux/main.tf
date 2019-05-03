resource "google_compute_instance" "hosts" {
  name                      = "${var.application}${format("%03d", count.index + 1)}"
  project                   = "${var.project_name}"
  count                     = "${var.fleet_size}"
  machine_type              = "${var.machine_type}"
  zone                      = "${count.index % 2 == 0 ? var.availability_zones["0"] : var.availability_zones["1"]}"
  allow_stopping_for_update = true

  tags = [
    "${var.instance_tags}",
  ]

  boot_disk {
    initialize_params {
      image = "${var.source_image}"
      size  = "${var.boot_disk_size}"
      type  = "${var.boot_disk_type}"
    }
  }

  labels = {
    owner                 = "${lookup(var.labels, "owner")}"
    confidentiality_level = "${lookup(var.labels, "confidentiality_level")}"
    metadata              = "${lookup(var.labels, "metadata")}"
  }

  metadata {
    // @TODO Change all "hostname" metadata to companyX_hostname
    companyX-hostname = "${var.application}${format("%03d", count.index + 1)}.${var.environment}.${var.region}.${var.domain}"
  }

  network_interface {
    subnetwork         = "${var.host_subnetwork}"
    subnetwork_project = "${var.host_project}"
  }

  scheduling {
    preemptible         = false
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  service_account {
    email  = "${var.service_account}"
    scopes = [
      "${var.scopes}",
    ]
  }
}

// @TODO Only uncomment when every bit of code pulling from this module also has the cloud-dns values in place as seen in tf-base/zones/shared-services/epehemeral/sensu/sensu-server.tf
module "cloud_dns" {
  source      = "../../modules/cloud-dns"
  project     = "${var.host_project}"
  environment = "${var.environment}"
  region      = "${var.region}"
  domain      = "${var.domain}"
  application = "${var.application}"
  ip_list     = "${join(",", google_compute_instance.hosts.*.network_interface.0.address)}"
  fleet_size  = "${google_compute_instance.hosts.count}"
}
