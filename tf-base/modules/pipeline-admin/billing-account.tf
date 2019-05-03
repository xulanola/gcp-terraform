resource "google_organization_iam_binding" "billing_user" {
  org_id = "${var.billing_org_id}"
  role   = "roles/billing.user"

  members = [
    "serviceAccount:${google_service_account.pipeline_admin.email}",
  ]
}
