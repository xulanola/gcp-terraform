# ----------------------------------------------------------------------------------
# COMMON VARIABLES
#
# ----------------------------------------------------------------------------------
variable "availability_zones" {
  type = "list"
}

variable "service_account" {}

variable "scopes" {
  type = "map"
}

# ----------------------------------------------------------------------------------
# NETWORK VARIABLES
#
# ----------------------------------------------------------------------------------
variable "host_subnetwork" {}

# ----------------------------------------------------------------------------------
# INSTANCE VARIABLES
#
# ----------------------------------------------------------------------------------
variable "application" {}

variable "source_image" {}
variable "machine_type" {}
variable "boot_disk_type" {}

variable "boot_disk_size" {
  default = 50
}

variable "host_project" {}
variable "fleet_size" {}

variable "labels" {
  type = "map"
}

variable "instance_tags" {
  type = "list"
}
