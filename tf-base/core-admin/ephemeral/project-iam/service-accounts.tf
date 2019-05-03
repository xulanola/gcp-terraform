# ----------------------------------------------------------------------------------
# SERVICE ACCOUNTS
# Create service accounts for specific zones
# ----------------------------------------------------------------------------------
resource "google_service_account" "companyX_cloud_racompanyX_bridge" {
  project      = "${var.project_name["racompanyX-bridge"]}"
  account_id   = "${var.environment}-companyX-cloud-racompanyX-bridge"
  display_name = "${var.environment} companyX Shared Services Zone Service Account"
}

resource "google_service_account" "companyX_shared_vpc" {
  project      = "${var.project_name["shared-vpc"]}"
  account_id   = "${var.environment}-companyX-shared-vpc"
  display_name = "${var.environment} companyX Shared VPC Zone Service Account"
}

resource "google_service_account" "companyX_vault" {
  project      = "${var.project_name["vault"]}"
  account_id   = "${var.environment}-companyX-vault"
  display_name = "${var.environment} companyX Vault Zone Service Account"
}

resource "google_service_account" "companyX_bulk_vault" {
  project      = "${var.project_name["bulk-vault"]}"
  account_id   = "${var.environment}-companyX-bulk-vault"
  display_name = "${var.environment} companyX Bulk Vault Zone Service Account"
}

resource "google_service_account" "companyX_front_end" {
  project      = "${var.project_name["front-end"]}"
  account_id   = "${var.environment}-companyX-front-end"
  display_name = "${var.environment} companyX Front End Zone Service Account"
}

resource "google_service_account" "companyX_back_end" {
  project      = "${var.project_name["back-end"]}"
  account_id   = "${var.environment}-companyX-back-end"
  display_name = "${var.environment} companyX back End Zone Service Account"
}

resource "google_service_account" "companyX_back_end_data" {
  project      = "${var.project_name["back-end-data"]}"
  account_id   = "${var.environment}-companyX-back-end-data"
  display_name = "${var.environment} companyX back End Data Zone Service Account"
}

resource "google_service_account" "companyX_shared_services" {
  project      = "${var.project_name["shared-services"]}"
  account_id   = "${var.environment}-companyX-shared-services"
  display_name = "${var.environment} companyX Shared Services Zone Service Account"
}

resource "google_service_account" "companyX_splunk_frozen_buckets" {
  project      = "${var.project_name["shared-services"]}"
  account_id   = "${var.environment}-companyX-splunk-frozen-buckets"
  display_name = "${var.environment} companyX Shared Services Splunk Frozen buckets Write and Read"
}

resource "google_service_account" "companyX_mgmt" {
  project      = "${var.project_name["management"]}"
  account_id   = "${var.environment}-companyX-mgmt"
  display_name = "${var.environment} companyX Management Zone Service Account"
}

//resource "google_project_iam_binding" "companyX_frontend_Actor" {
//  project = "${var.project_name["front-end"]}"
//  role    = "roles/iam.serviceAccountActor"
//  members = [
//    "serviceaccount:${var.service_account["front-end"]}"
//  ]
//}


# ----------------------------------------------------------------------------------
# SETUP TRANSIT VPC SERVICE ACCOUNT
# @TODO determine is this is redundant
# ----------------------------------------------------------------------------------
//resource "google_service_account" "cloud_racompanyX_bridge" {
//  account_id   = "${var.service_account_id["transit-vpc"]}"
//  display_name = "${var.service_account_id["transit-vpc"]}"
//  project      = "${var.project_name["racompanyX-bridge"]}"
//}

