# ----------------------------------------------------------------------------------
# COMMON VARIABLES
#
# ----------------------------------------------------------------------------------
variable "org_id" {}

variable "billing_account_id" {}

variable "project_name" {
  type = "map"
}

variable "region" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "owner" {
  type = "map"
}

variable "metadata" {}
variable "environment" {}

variable "service_apis" {
  type = "list"
}

variable "roles" {
  type = "map"
}

# ----------------------------------------------------------------------------------
# NETWORK VARIABLES
#
# ----------------------------------------------------------------------------------
variable "cidrs" {
  type = "map"
}

variable "known_ips" {
  type = "map"
}

variable "vlans" {
  type = "map"
}

variable "project-tags" {
  type = "map"
}

variable "subnetwork_name" {
  type = "map"
}

variable "host_network" {
  type = "map"
}

variable "companyX_supernet" {
  type = "map"
}

variable "companyXe_proxy" {
  type = "list"
}

variable "companyXw_proxy" {
  type = "list"
}

variable "google_health_checompanyX" {
  type = "list"
}

variable "application" {
  type = "map"
}
