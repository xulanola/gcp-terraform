# ----------------------------------------------------------------------------------
# SETUP ALL PROJECTS
# Configure all projects and give them random IDs
# ----------------------------------------------------------------------------------
# @TODO Figure out a better way to manage folder hiearchy

###
## Set up the random hex strings for project_id
#
provider "random" {}

resource "random_id" "prod_host_project_name" {
  byte_length = 4
}

resource "random_id" "nonprod_host_project_name" {
  byte_length = 4
}

resource "random_id" "dev_project_name" {
  byte_length = 4
}

resource "random_id" "nonprod_vpn" {
  byte_length = 4
}

resource "random_id" "nonprod_natgw" {
  byte_length = 4
}

resource "random_id" "nonprod_shared_services" {
  byte_length = 4
}

###
## The projects which owns the shared VPC.
#
resource "google_project" "prod_shared_vpc" {
  name       = "gcp-prd-shared-vpc"
  project_id = "gcp-prd-shared-vpc-${random_id.prod_host_project_name.hex}"

  #org_id          = "${var.org_id}"
  folder_id       = "454115262147"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "nonprod_shared_vpc" {
  name       = "gcp-nonprd-shared-vpc"
  project_id = "gcp-nonprd-shared-vpc-${random_id.nonprod_host_project_name.hex}"

  #org_id          = "${var.org_id}"
  folder_id       = "100061378350"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "dev" {
  name       = "gcp-nonprd-dev"
  project_id = "gcp-nonprd-dev-${random_id.dev_project_name.hex}"

  #org_id          = "${var.org_id}"
  folder_id       = "100061378350"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "nonprod_vpn" {
  name       = "gcp-nonprd-vpn"
  project_id = "gcp-nonprd-vpn-${random_id.nonprod_vpn.hex}"

  #org_id          = "${var.org_id}"
  folder_id       = "100061378350"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "nonprod_natgw" {
  name       = "gcp-nonprd-natgw"
  project_id = "gcp-nonprd-natgw-${random_id.nonprod_natgw.hex}"

  #org_id          = "${var.org_id}"
  folder_id       = "100061378350"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "nonprod_shared_services" {
  name       = "gcp-nonprd-shared-services"
  project_id = "gcp-nonprd-shared-svc-${random_id.nonprod_shared_services.hex}"

  #org_id          = "${var.org_id}"
  folder_id       = "100061378350"
  billing_account = "${var.billing_account_id}"
}

# ----------------------------------------------------------------------------------
# ENABLE GCP APIS
# APIs set in common vars
# ----------------------------------------------------------------------------------
resource "google_project_services" "nonprod_shared_vpc" {
  project  = "${google_project.dev.project_id}"
  services = "${var.service_apis}"
}

resource "google_project_services" "prod_shared_vpc" {
  project  = "${google_project.dev.project_id}"
  services = "${var.service_apis}"
}

resource "google_project_services" "dev" {
  project  = "${google_project.dev.project_id}"
  services = "${var.service_apis}"
}

resource "google_project_services" "nonprod_vpn" {
  project  = "${google_project.nonprod_vpn.project_id}"
  services = "${var.service_apis}"
}

resource "google_project_services" "nonprod_natgw" {
  project  = "${google_project.nonprod_natgw.project_id}"
  services = "${var.service_apis}"
}

resource "google_project_services" "nonprod_shared_services" {
  project  = "${google_project.nonprod_shared_services.project_id}"
  services = "${var.service_apis}"
}

###
## Enable shared VPC hosting in the host project.
#
resource "google_compute_shared_vpc_host_project" "prod_host_project" {
  project = "${google_project.prod_shared_vpc.project_id}"
}

resource "google_compute_shared_vpc_host_project" "nonprod_host_project" {
  project = "${google_project.nonprod_shared_vpc.project_id}"
}

# ----------------------------------------------------------------------------------
# ENABLE SHARED VPC IN SPECIFIC PROJECTS
# Explicitly depend on the host project enabling it, because enabling
# shared VPC will fail if the host project is not yet hosting.
# ----------------------------------------------------------------------------------
resource "google_compute_shared_vpc_service_project" "dev" {
  host_project    = "${google_project.nonprod_shared_vpc.project_id}"
  service_project = "${google_project.dev.project_id}"

  depends_on = [
    "google_compute_shared_vpc_host_project.nonprod_host_project",
  ]
}

resource "google_compute_shared_vpc_service_project" "nonprod_vpn" {
  host_project    = "${google_project.nonprod_shared_vpc.project_id}"
  service_project = "${google_project.nonprod_vpn.project_id}"

  depends_on = [
    "google_compute_shared_vpc_host_project.nonprod_host_project",
  ]
}

resource "google_compute_shared_vpc_service_project" "nonprod_natgw" {
  host_project    = "${google_project.nonprod_shared_vpc.project_id}"
  service_project = "${google_project.nonprod_natgw.project_id}"

  depends_on = [
    "google_compute_shared_vpc_host_project.nonprod_host_project",
  ]
}

resource "google_compute_shared_vpc_service_project" "nonprod_shared_services" {
  host_project    = "${google_project.nonprod_shared_vpc.project_id}"
  service_project = "${google_project.nonprod_shared_services.project_id}"

  depends_on = [
    "google_compute_shared_vpc_host_project.nonprod_host_project",
  ]
}
