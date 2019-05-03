provider "random" {}

resource "random_id" "string" {
  byte_length = 4
}

resource "google_project" "pipeline_admin" {
  name            = "${var.project_name["admin"]}"
  project_id      = "${var.project_name["admin"]}-${random_id.string.hex}"
  org_id          = "${var.org_id}"
  billing_account = "${var.billing_account}"
}

resource "google_project_services" "pipeline_admin_services" {
  project = "${google_project.pipeline_admin.project_id}"

  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "servicemanagement.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]
}
