// @TODO Need to refactor this whole module to be less dependant on hard coded values
resource "google_organization_iam_binding" "project_creator" {
  org_id = "${var.org_id}"
  role   = "roles/resourcemanager.projectCreator"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_organization_iam_binding" "project_deleter" {
  org_id = "${var.org_id}"
  role   = "roles/resourcemanager.projectDeleter"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_organization_iam_binding" "compute_xpn_admin" {
  org_id = "${var.org_id}"
  role   = "roles/compute.xpnAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_organization_iam_binding" "compute_security_admin" {
  org_id = "${var.org_id}"
  role   = "roles/compute.securityAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "dns_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/dns.admin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "pubsub_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/pubsub.admin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "storage_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "storage_object_admin" {
  project = "${var.terraform_states_project_name}"
  role    = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "compute_instance_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/compute.instanceAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "compute_instance_admin_v1" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/compute.instanceAdmin.v1"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "compute_network_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/compute.networkAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "compute_storage_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/compute.storageAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "compute_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/compute.admin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "service_account_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/iam.serviceAccountAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "service_account_key_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/iam.serviceAccountKeyAdmin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "service_account_user" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "logging_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/logging.admin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}

resource "google_project_iam_binding" "monitoring_admin" {
  project = "${google_project.pipeline_admin.project_id}"
  role    = "roles/monitoring.admin"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}
