# ----------------------------------------------------------------------------------
# COMPUTE ROLES
# Enable compute roles for specified projects
# @TODO pull in projects from remote state
# ----------------------------------------------------------------------------------
###
## Set roles/compute.instanceAdmin
#
resource "google_project_iam_binding" "computeinstanceAdmin_cloud_racompanyX_bridge" {
  project = "${var.project_name["racompanyX-bridge"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_cloud_racompanyX_bridge.email}",
  ]
}

resource "google_project_iam_binding" "computeinstanceAdmin_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
  ]
}

resource "google_project_iam_binding" "computeinstanceAdmin_companyX_vault" {
  project = "${var.project_name["vault"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_vault.email}",
  ]
}

resource "google_project_iam_binding" "computeinstanceAdmin_companyX_bulk_vault" {
  project = "${var.project_name["bulk-vault"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_bulk_vault.email}",
  ]
}

resource "google_project_iam_binding" "computeinstanceAdmin_companyX_be_data" {
  project = "${var.project_name["back-end-data"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_back_end_data.email}",
  ]
}

resource "google_project_iam_binding" "computeinstanceAdmin_companyX_shared_services" {
  project = "${var.project_name["shared-services"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_services.email}",
  ]
}

resource "google_project_iam_binding" "computeinstanceAdmin_companyX_mgmt" {
  project = "${var.project_name["management"]}"
  role    = "${var.roles["b-computeinstanceAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_mgmt.email}",
  ]
}

###
## Set roles/computeAdmin
#
resource "google_project_iam_binding" "computeAdmin_cloud_racompanyX_bridge" {
  project = "${var.project_name["racompanyX-bridge"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_cloud_racompanyX_bridge.email}",
  ]
}

resource "google_project_iam_binding" "computeAdmin_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
  ]
}

resource "google_project_iam_binding" "computeAdmin_companyX_vault" {
  project = "${var.project_name["vault"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_vault.email}",
  ]
}

resource "google_project_iam_binding" "computeAdmin_companyX_bulk_vault" {
  project = "${var.project_name["bulk-vault"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_bulk_vault.email}",
  ]
}

resource "google_project_iam_binding" "computeAdmin_companyX_be_data" {
  project = "${var.project_name["back-end-data"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_back_end_data.email}",
  ]
}

resource "google_project_iam_binding" "computeAdmin_companyX_shared_services" {
  project = "${var.project_name["shared-services"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_services.email}",
  ]
}

resource "google_project_iam_binding" "computeAdmin_companyX_mgmt" {
  project = "${var.project_name["management"]}"
  role    = "${var.roles["b-computeAdmin"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_mgmt.email}",
  ]
}

###
## Set roles/computeimageUser
#
resource "google_project_iam_binding" "computeimageUser_cloud_racompanyX_bridge" {
  project = "${var.project_name["racompanyX-bridge"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_cloud_racompanyX_bridge.email}",
  ]
}

resource "google_project_iam_binding" "computeimageUser_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
  ]
}

resource "google_project_iam_binding" "computeimageUser_companyX_vault" {
  project = "${var.project_name["vault"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_vault.email}",
  ]
}

resource "google_project_iam_binding" "computeimageUser_companyX_bulk_vault" {
  project = "${var.project_name["bulk-vault"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_bulk_vault.email}",
  ]
}

resource "google_project_iam_binding" "computeimageUser_companyX_be_data" {
  project = "${var.project_name["back-end-data"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_back_end_data.email}",
  ]
}

resource "google_project_iam_binding" "computeimageUser_companyX_shared_services" {
  project = "${var.project_name["shared-services"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_shared_services.email}",
  ]
}

resource "google_project_iam_binding" "computeimageUser_companyX_mgmt" {
  project = "${var.project_name["management"]}"
  role    = "${var.roles["computeimageUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_mgmt.email}",
  ]
}

#@TODO This does not work
//resource "google_project_iam_binding" "image_user_prod_companyX_admin" {
//  project = "${var.project_name["shared-vpc"]}"
//  role    = "${var.roles["computeimageUser"]}"
//
//  members = [
//    "serviceAccount:${google_service_account.companyX_cloud_racompanyX_bridge.email}",
//    "serviceAccount:${google_service_account.companyX_shared_vpc.email}",
//    "serviceAccount:${google_service_account.companyX_vault.email}",
//    "serviceAccount:${google_service_account.companyX_bulk_vault.email}",
//    "serviceAccount:${google_service_account.companyX_front_end.email}",
//    "serviceAccount:${google_service_account.companyX_back_end.email}",
//    "serviceAccount:${google_service_account.companyX_back_end_data.email}",
//    "serviceAccount:${google_service_account.companyX_shared_services.email}",
//    "serviceAccount:${google_service_account.companyX_mgmt.email}",
//  ]
//}
