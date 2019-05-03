data "template_file" "attach_and_format_disk" {
  count    = "${var.fleet_size}"
  template = "${file("${path.module}/attach-and-format-disks.sh")}"

  vars {
    first_disk_id = "${count.index * var.num_attached_disks + 1}"
  }
}

resource "google_compute_disk" "attached_shards" {
  project = "${var.project_name}"
  count   = "${var.fleet_size * var.num_attached_disks}"
  name    = "${var.application}${format("%03d", count.index / var.num_attached_disks + 1)}-${format("sdb%d", count.index + 1)}"
  type    = "${var.attached_disk_type}"
  zone    = "${var.availability_zone}"
  size    = "${var.attached_disk_size}"
}

resource "google_compute_instance" "sharded_db_servers" {
  project                   = "${var.project_name}"
  count                     = "${var.fleet_size}"
  name                      = "${var.application}${format("%03d", count.index + 1)}"
  machine_type              = "${var.machine_type}"
  min_cpu_platform          = "${var.machine_type_cpu}"
  zone                      = "${var.availability_zone}"
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

  attached_disk {
    source = "${element(google_compute_disk.attached_shards.*.self_link, count.index * var.num_attached_disks + 0)}"
  }

  attached_disk {
    source = "${element(google_compute_disk.attached_shards.*.self_link, count.index * var.num_attached_disks + 1)}"
  }

  attached_disk {
    source = "${element(google_compute_disk.attached_shards.*.self_link, count.index * var.num_attached_disks + 2)}"
  }

  attached_disk {
    source = "${element(google_compute_disk.attached_shards.*.self_link, count.index * var.num_attached_disks + 3)}"
  }

  metadata {
    startup-script = "${element(data.template_file.attach_and_format_disk.*.rendered, count.index)}"
    companyX-hostname    = "${var.application}${format("%03d", count.index +1 )}.prod.us-central1.companyXint.io"
  }

  network_interface {
    subnetwork         = "${var.host_subnetwork}"
    subnetwork_project = "${var.host_project}"
  }

  scheduling {
    preemptible         = false
    on_host_maintenance = "MIGRATE"

    #@TODO auto-restart not being set to false on the instance
    automatic_restart = false
  }

  //  service_account {
  //    email  = "${var.service_account}"
  //    scopes = [
  //      "${var.scopes}",
  //    ]
  //  }
}

// Documentation : Can't define project twice

module "cloud_dns" {
  source      = "../../modules/cloud-dns"
  project     = "${var.host_project}"
  environment = "${var.environment}"
  region      = "${var.region}"
  domain      = "${var.domain}"
  application = "${var.application}"
  ip_list     = "${join(",", google_compute_instance.sharded_db_servers.*.network_interface.0.address)}"
  fleet_size  = "${google_compute_instance.sharded_db_servers.count}"
}
