provider "google" {
  region = "${element(var.region, 0)}"
}

terraform {
  required_version = ">= 0.10.4"
  backend          "gcs"            {}
}
