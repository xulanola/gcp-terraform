# ----------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These parameters are required by most deployments
# ----------------------------------------------------------------------------------
environment          = "qa3"
billing_account_id   = "01B511-5F510F-0D9551"
org_id               = "5810863792"

project_name         = {
  "shared-vpc"      = ""
}

# ----------------------------------------------------------------------------------
# PERMISSION PARAMETERS
# These parameters are required to specify access to service accounts
# ----------------------------------------------------------------------------------
service_account      = {
  "pipeline-admin"  = ""
}

service_account_id   = {
  "transit-vpc" = "cloud-rack-bridge"
}

permission_architect = [
  "user:eric.fouarge@mavenwave.com"
]

permission_engineer  = [
  "user:eric.fouarge@mavenwave.com"
]

permission_user      = []


# ----------------------------------------------------------------------------------
# NETWORK PARAMETERS
# These parameters are for speciying networks/subnetworks/cidrs
# ----------------------------------------------------------------------------------
host_network         = {
  shared-vpc = ""
}


host_subnetwork      = {
}

host_project         = {
  shared-vpc = ""
}

###
## Common CIDRS
#
cidrs                = {
  "shared-vpc"    = "10.136.0.0/14"
  "customer-side" = "10.137.114.0/24"
}

// @TODO Change names to zone names but allowing for multi-regional support
vlans              = {}
// @TODO Change names to zone names but allowing for multi-regional support
project-tags       = {}

subnetwork_name      = {
  "rack"     = "rack_side"
  "customer" = "customer_side"
}


# ----------------------------------------------------------------------------------
# INSTANCE PARAMETERS
# These parameters are for most instance deployments
# To get a list of images - gcloud compute images list
# ----------------------------------------------------------------------------------
#@TODO this is currently only using one CentOS image due to issues with pulling from the prod images
source_image         = {
  "base-centos7"       = "centos-7-v20180227"
}