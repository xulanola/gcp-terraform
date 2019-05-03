module "admin" {
  source                        = "../../../modules/pipeline-admin"
  org_id                        = "${var.org_id}"
  billing_org_id                = "${var.billing_org_id}"
  billing_account               = "${var.billing_account_id}"
  account_id                    = "${var.project_name["pipeline-admin"]}"
  project_name                  = "${var.project_name}"
  terraform_states_project_name = "${var.project_name["terraform"]}"
}
