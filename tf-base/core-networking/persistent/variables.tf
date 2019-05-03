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

#variable "owner" {
#  type = "map"
#}

variable "metadata" {}
variable "environment" {}

variable "service_apis" {
  type = "list"
}

#variable "scopes" {}

# ----------------------------------------------------------------------------------
# PERMISSION VARIABLES
#
# ----------------------------------------------------------------------------------
variable "permission_architect" {
  type = "list"
}

variable "permission_engineer" {
  type = "list"
}

variable "permission_user" {
  type = "list"
}

variable "service_account" {
  type = "map"
}

variable "service_account_id" {
  type = "map"
}

variable "vlans" {
  type = "map"
}

# ----------------------------------------------------------------------------------
# VPN GATEWAY VARIABLES
#
# ----------------------------------------------------------------------------------
variable "companyX_peer_ip" {
  type = "map"
}

variable "companyX_supernet" {
  type = "map"
}

variable "companyX_route_priority" {
  type = "map"
}

# ----------------------------------------------------------------------------------
# NETWORK VARIABLES
#
# ----------------------------------------------------------------------------------
variable "cidrs" {
  type = "map"
}

variable "subnetwork_name" {
  type = "map"
}

# ----------------------------------------------------------------------------------
# INSTANCE VARIABLES
#
# ----------------------------------------------------------------------------------
variable "source_image" {
  type = "map"
}

variable "machine_type" {
  type = "map"
}

variable "boot_disk_type" {
  type = "map"
}

variable "boot_disk_size" {
  default = 512
}

variable "host_project" {
  type = "map"
}

variable "host_network" {
  type = "map"
}

variable "confidentiality_level" {
  type = "map"
}

#variable "application" {
#  type = "list"
#}

variable "fleet_size" {
  type = "map"
}

variable "instance_tags" {
  type = "list"

  default = [
    "project-10-x-24-0-22",
    "region-west-10-136-0-0-15",
  ]
}
