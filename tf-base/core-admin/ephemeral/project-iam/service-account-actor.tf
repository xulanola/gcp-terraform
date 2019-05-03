###
## Set roles/iam.serviceAccountActor
#
resource "google_project_iam_binding" "iamserviceAccountActor_shared_vpc" {
  project = "${var.project_name["shared-vpc"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}

resource "google_project_iam_binding" "iamserviceAccountActor_companyX_vault" {
  project = "${var.project_name["vault"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}

resource "google_project_iam_binding" "iamserviceAccountActor_companyX_bulk_vault" {
  project = "${var.project_name["bulk-vault"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}

resource "google_project_iam_binding" "iamserviceAccountActor_companyX_front-end" {
  project = "${var.project_name["front-end"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}

resource "google_project_iam_binding" "iamserviceAccountActor_companyX_back-end" {
  project = "${var.project_name["back-end"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}

resource "google_project_iam_binding" "iamserviceAccountActor_companyX_be_data" {
  project = "${var.project_name["back-end-data"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}

resource "google_project_iam_binding" "iamserviceAccountActor_companyX_shared_services" {
  project = "${var.project_name["shared-services"]}"
  role    = "${var.roles["iamserviceAccountActor"]}"

  members = [
    "serviceAccount:${var.service_account["pipeline-admin"]}",
  ]
}