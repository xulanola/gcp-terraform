variable "project_name" {}

variable "fleet_size" {}

variable "machine_specs" {
  type = "map"
}

variable "boot_disk_type" {}

variable "attached_disk_type" {}

variable "availability_zone" {}

variable "instance_tags" {
  type = "list"
}

variable "source_image" {}

variable "boot_disk_size" {}

variable "attached_disk_size" {}

variable "num_attached_disks" {}

variable "labels" {
  type = "map"
}

variable "domain" {}

variable "region" {}

variable "environment" {}

variable "application" {}

variable "service_account" {}

# ----------------------------------------------------------------------------------
# NETWORK VARIABLES
#
# ----------------------------------------------------------------------------------
variable "host_subnetwork" {}

variable "host_project" {}