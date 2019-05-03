# ----------------------------------------------------------------------------------
# PROJECT EXPLICIT ACCESS
# Set here specific IAM roles for service account users for unique projects
# ----------------------------------------------------------------------------------
resource "google_project_iam_binding" "prod_shared_vpc_project" {
  project = "${google_project.prod_shared_vpc.project_id}"
  role    = "roles/editor"
  members = "${var.permission_architect}"
}

resource "google_project_iam_binding" "nonprod_shared_vpc_project" {
  project = "${google_project.nonprod_shared_vpc.project_id}"
  role    = "roles/editor"
  members = "${var.permission_architect}"
}

resource "google_project_iam_binding" "dev_project" {
  project = "${google_project.dev.project_id}"
  role    = "roles/editor"
  members = "${concat(var.permission_architect, var.permission_engineer)}"
}

resource "google_project_iam_binding" "nonprod_vpn" {
  project = "${google_project.nonprod_vpn.project_id}"
  role    = "roles/editor"
  members = "${concat(var.permission_architect, var.permission_engineer)}"
}

resource "google_project_iam_binding" "nonprod_natgw" {
  project = "${google_project.nonprod_natgw.project_id}"
  role    = "roles/editor"
  members = "${concat(var.permission_architect, var.permission_engineer)}"
}

resource "google_project_iam_binding" "nonprod_shared_services" {
  project = "${google_project.nonprod_shared_services.project_id}"
  role    = "roles/editor"
  members = "${concat(var.permission_architect, var.permission_engineer)}"
}
