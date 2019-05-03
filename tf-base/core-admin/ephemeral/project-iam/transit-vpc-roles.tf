# ----------------------------------------------------------------------------------
# SETUP TRANSIT VPC ROLES
#
# ----------------------------------------------------------------------------------
###
## Transit-VPC Roles
#
resource "google_project_iam_binding" "computenetworkAdmin_cloud_racompanyX_bridge" {
  project = "${var.project_name["racompanyX-bridge"]}"
  role    = "${var.roles["computenetworkAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_cloud_racompanyX_bridge.email}",
  ]
}

###
## Shared-VPC Roles
#
resource "google_project_iam_binding" "computenetworkAdmin_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["computenetworkAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
  ]
}

resource "google_project_iam_binding" "computesecurityAdmin_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["computesecurityAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
  ]
}
