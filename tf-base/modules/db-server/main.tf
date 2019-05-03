data "template_file" "attach_and_format_disk" {
  template = "${file("${path.module}/attach-and-format-disk.sh")}"
}

resource "google_compute_disk" "attached_disks" {
  project = "${var.project_name}"
  count   = "${var.fleet_size}"
  name    = "${var.application}${format("%03d", count.index + 1)}-attached"
  type    = "${var.attached_disk_type}"
  zone    = "${var.availability_zone}"
  size    = "${var.attached_disk_size}"
}

resource "google_compute_instance" "db_servers" {
  project          = "${var.project_name}"
  count            = "${var.fleet_size}"
  name             = "${var.application}${format("%03d", count.index + 1)}"
  machine_type     = "${lookup(var.machine_specs, "machine_type")}"
  min_cpu_platform = "${lookup(var.machine_specs, "min_cpu_platform")}"
  zone             = "${var.availability_zone}"

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

  attached_disk {
    source = "${google_compute_disk.attached_disks.*.self_link[count.index + 0]}"
  }

  metadata {
    startup-script = "${data.template_file.attach_and_format_disk.rendered}"
    hostname       = "${var.application}${format("%03d", count.index + 1)}.${var.environment}.${var.region["0"]}.${var.domain}"
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

  //  service_account {
  //    email  = "${var.service_account}"
  //
  //    scopes = [
  //      "https://www.googleapis.com/auth/cloud-platform",
  //    ]
  //  }
}

module "cloud_dns" {
  source      = "../../modules/cloud-dns"
  project     = "${var.host_project}"
  environment = "${var.environment}"
  region      = "${var.region}"
  domain      = "${var.domain}"
  application = "${var.application}"
  ip_list     = "${join(",", google_compute_instance.db_servers.*.network_interface.0.address)}"
  fleet_size  = "${google_compute_instance.db_servers.count}"
}