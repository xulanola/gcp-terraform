# ----------------------------------------------------------------------------------
# TERRAGRUNT CONFIG
# Replicate this file to every folder which holds any *.tf files
# ----------------------------------------------------------------------------------
terragrunt = {
  remote_state {
    backend = "gcs"
    config {
      bucket      = "${get_env("ENV", "default")}-companyX-terraform-states"
      prefix      = "${get_env("ENV", "default")}-core-networking/persistent/terraform.tfstate"
      //prefix      = "transit-vpc-${get_env("ENV", "default")}.tfstate" @TODO make sure to move the networking state to above instead of this line
      credentials = "${get_env("GOOGLE_APPLICATION_CREDENTIALS", "default")}"
      project     = "${get_env("GOOGLE_PROJECT", "terraform-admin-203523")}"
    }
  }

  terraform {
    # Force Terraform to keep trying to acquire a lock for up to 20 minutes
    # if someone else already has the lock.
    extra_arguments "retry_lock" {
      commands  = [
        "init",
        "apply",
        "refresh",
        "import",
        "plan",
        "taint",
        "untaint",
        "destroy"
      ]

      arguments = [
        "-lock-timeout=20m",
        "-var-file=${get_tfvars_dir()}/../../envars/common.tfvars",
        "-var-file=${get_tfvars_dir()}/../../envars/${get_env("ENV", "default")}.tfvars",
        "-var-file=terraform.tfvars"
      ]
    }
  }
}