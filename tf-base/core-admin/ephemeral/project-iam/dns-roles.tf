###
## Set roles/dns.admin
#
resource "google_project_iam_binding" "dnsAdmin_cloud_racompanyX_bridge" {
  project = "${var.project_name["racompanyX-bridge"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_cloud_racompanyX_bridge.email}",
  ]
}

resource "google_project_iam_binding" "dnsAdmin_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
  ]
}

resource "google_project_iam_binding" "dnsAdmin_companyX_vault" {
  project = "${var.project_name["vault"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_vault.email}",
  ]
}

resource "google_project_iam_binding" "dnsAdmin_companyX_bulk_vault" {
  project = "${var.project_name["bulk-vault"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_bulk_vault.email}",
  ]
}

resource "google_project_iam_binding" "dnsAdmin_companyX_be_data" {
  project = "${var.project_name["back-end-data"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_back_end_data.email}",
  ]
}

resource "google_project_iam_binding" "dnsAdmin_companyX_shared_services" {
  project = "${var.project_name["shared-services"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_services.email}",
  ]
}

resource "google_project_iam_binding" "dnsAdmin_companyX_mgmt" {
  project = "${var.project_name["management"]}"
  role    = "${var.roles["dnsAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_mgmt.email}",
  ]
}
