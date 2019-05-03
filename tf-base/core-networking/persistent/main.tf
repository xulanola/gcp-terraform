# ----------------------------------------------------------------------------------
# SHARED VPC NETWORK CREATION
# https://cloud.google.com/vpc/docs/shared-vpc
# @TODO for "project" we should be pulling in from a data source and not a variable
# ----------------------------------------------------------------------------------

resource "google_compute_network" "prod_shared_network" {
  name                    = "shared-network"
  project                 = "${google_compute_shared_vpc_host_project.prod_host_project.project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "nonprod_shared_network" {
  name                    = "shared-network"
  project                 = "${google_compute_shared_vpc_host_project.nonprod_host_project.project}"
  auto_create_subnetworks = "false"
}

# Top-level folder under an organization.
#resource "google_folder" "prod" {
#  display_name = "prod"
#  parent     = "GoogleCloudPlatform"
#}


#resource "google_folder" "nonprod" {
#  display_name = "nonprod"
#  parent     = " organizations/GoogleCloudPlatform"
#}


#resource "google_folder" "dev" {
#  display_name = "dev"
#  parent = "${google_folder.nonprod.id}"
#}

