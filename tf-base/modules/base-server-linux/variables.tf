# ----------------------------------------------------------------------------------
# COMMON VARIABLES
#
# ----------------------------------------------------------------------------------
variable "region" {}

variable "availability_zones" {
  type = "list"
}

variable "environment" {}

variable "domain" {}

variable "service_account" {}

variable "scopes" {}

# ----------------------------------------------------------------------------------
# NETWORK VARIABLES
#
# ----------------------------------------------------------------------------------
variable "host_subnetwork" {}

variable "host_project" {}

# ----------------------------------------------------------------------------------
# INSTANCE VARIABLES
#
# ----------------------------------------------------------------------------------
variable "project_name" {}

variable "application" {}
variable "source_image" {}
variable "machine_type" {}
variable "boot_disk_type" {}

variable "boot_disk_size" {
  default = 50
}

variable "fleet_size" {}

variable "labels" {
  type = "map"
}

variable "instance_tags" {
  type = "list"
}
