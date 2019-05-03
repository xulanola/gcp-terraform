resource "google_service_account" "pipeline_admin" {
  account_id   = "${var.account_id}"
  display_name = "${var.account_id}"
  project      = "${google_project.pipeline_admin.project_id}"
}
