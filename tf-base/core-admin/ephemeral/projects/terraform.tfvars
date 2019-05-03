terragrunt = {
  remote_state {
    backend = "gcs"
    config {
      bucket  = "${get_env("ENV", "default")}-companyX-terraform-states"
      prefix  = "${get_env("ENV", "default")}-companyX-admin/projects/terraform.tfstate"
      credentials = "${get_env("GOOGLE_APPLICATION_CREDENTIALS", "default")}"
      project = "${get_env("GOOGLE_PROJECT", "terraform-admin")}"
    }
  }

  terraform {
    # Force Terraform to keep trying to acquire a lock for up to 20 minutes
    # if someone else already has the lock.
    extra_arguments "retry_lock" {
      commands = [
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
        "-lock-timeout=30s",
        "--var-file=${get_tfvars_dir()}/../../../envars/common.tfvars",
        "--var-file=${get_tfvars_dir()}/../../../envars/${get_env("ENV", "default")}.tfvars",
        "--var-file=terraform.tfvars"
      ]
    }
  }
}
