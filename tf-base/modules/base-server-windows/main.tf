# ----------------------------------------------------------------------------------
# @TODO Need to pull out all labels and find a way to correctly define maps in modules
#
# ----------------------------------------------------------------------------------

resource "google_compute_instance" "windows_hosts" {
  name                      = "w-${var.application}${format("%03d", count.index + 1)}"
  project                   = "${var.host_project}"
  count                     = "${var.fleet_size}"
  machine_type              = "${var.machine_type}"
  zone                      = "${count.index % 2 == 0 ? element(var.availability_zones, 0) : element(var.availability_zones, 1)}"
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

  network_interface {
    subnetwork         = "${var.host_subnetwork}"
    subnetwork_project = "${var.host_project}"
  }

  scheduling {
    preemptible         = false
    on_host_maintenance = "MIGRATE"
    automatic_restart   = false
  }

  # service_account {
  #   email  = "${var.service_account}"
  #
  #   scopes = [
  #     "${var.scopes}",
  #   ]
  # }
}
