resource "google_storage_bucket" "bucket" {
  name                      = "${var.bucket_name}"
  project                   = "${var.project_name}"
  location                  = "${var.region}"
  storage_class             = "${var.storage_class}"

  labels = {
    owner                 = "${var.owner}"
    confidentiality_level = "${var.confidentiality_level}"
    metadata              = "${var.metadata}"
  }
}