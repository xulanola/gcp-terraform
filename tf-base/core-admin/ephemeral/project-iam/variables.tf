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
# PERMISSION VARIABLES
#
# ----------------------------------------------------------------------------------

# @TODO: determine these are needed

#variable "permission_architect" {
#  type = "list"
#}

#variable "permission_engineer" {
#  type = "list"
#}

#variable "permission_user" {
#  type = "list"
#}

variable "service_account" {
  type = "map"
}

variable "service_account_id" {
  type = "map"
}
