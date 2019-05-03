# ----------------------------------------------------------------------------------
# TERRAFORM CONFIG
# This file should be present for every folder that holds a unique state file
# All folder config settings should reside here
# ----------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.10.4"
  backend          "gcs"            {}
}

provider "google" {
  region = "${element(var.region, 0)}"
}
