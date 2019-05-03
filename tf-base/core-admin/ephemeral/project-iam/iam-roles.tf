###
## Set roles/iam.serviceAccountUser
#



resource "google_project_iam_binding" "iamserviceAccountUser_companyX_be_data" {
  project = "${var.project_name["back-end-data"]}"
  role    = "${var.roles["iamserviceAccountUser"]}"

  members = [
    "serviceAccount:${google_service_account.companyX_back_end_data.email}",
  ]
}

