# ----------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These parameters are required by most deployments
# ----------------------------------------------------------------------------------
environment          = "prd"
billing_account_id   = "01B511-5F510F-0D9551"
org_id               = "5810863792"
# Support for Separate Org Billing
billing_org_id       = "5810863792"


project_name       = {
  "forseti"         = "companyX-forseti"
  "terraform"       = "terraform-admin"
  "pipeline-admin"  = "terraform-admin"
  "admin"           = "companyX-admin"
}

# ----------------------------------------------------------------------------------
# PERMISSION PARAMETERS
# These parameters are required to specify access to service accounts
# ----------------------------------------------------------------------------------
service_account    = {
}

service_account_id = {
  "transit-vpc" = "cloud-racompanyX-bridge"
}


# ----------------------------------------------------------------------------------
# NETWORK PARAMETERS
# These parameters are for speciying networks/subnetworks/cidrs
# ----------------------------------------------------------------------------------
host_network       = {
  shared-vpc = "prod-shared-vpc-network-10-136-0-0-14"
}

# These are prod only right now
# @TODO FIX: these networks for multi-environment support
host_subnetwork    = {
  front-end       = "us-central1-10-137-0-0-22"
  back-end        = "us-central1-10-137-8-0-22"
  shared-services = "us-central1-10-137-16-0-22"
  vault           = "us-central1-10-137-24-0-22"
  bulk-vault      = "us-central1-10-137-32-0-22"
  admin           = "us-central1-10-137-40-0-22"
  back-end-data   = "us-central1-10-137-48-0-22"
}

host_project       = {
  shared-vpc = "prod-shared-vpc-host-project"
}

###
## Common CIDRS
#
cidrs              = {
  "outside"       = "172.16.10.0/24"
  "transit"       = "172.16.15.0/24"
  "shared-vpc"    = "10.136.0.0/14"
  "customer-side" = "10.137.114.0/24"
  "racompanyX-side"     = "10.137.115.0/24"
  "cloud-racompanyX"    = "10.137.112.0/24"
}

vlans              = {
  "us-central1-front-end"       = "10.137.0.0/22"
  "us-central1-back-end"        = "10.137.8.0/22"
  "us-central1-shared-services" = "10.137.16.0/22"
  "us-central1-vault"           = "10.137.24.0/22"
  "us-central1-bulk-vault"      = "10.137.32.0/22"
  "us-central1-admin"           = "10.137.40.0/22"
  "us-central1-back-end-data"   = "10.137.48.0/22"
}

# @TODO fix the project tag to snake

project-tags       = {
  "us-central1-web"        = "project-10-x-0-0-22"
  "us-central1-bg"         = "project-10-x-8-0-22"
  "us-central1-mgmt"       = "project-10-x-16-0-22"
  "us-central1-vapi"       = "project-10-x-24-0-22"
  "us-central1-bulk-vault" = "project-10-x-32-0-22"
  "us-central1-db"         = "project-10-x-48-0-22"
}

subnetwork_name    = {
  "racompanyX"     = "racompanyX_side"
  "customer" = "customer_side"
}

###
## Cloud RacompanyX VPN Information
#
companyX_peer_ip         = {
  "east" = ""
  "west" = "204.16.72.120"
}
companyX_supernet        = {
  "nonprod" = "10.0.0.0/8"
  "prod" = "172.16.0.0/12"
}
companyX_route_priority  = {
  "a-route" = "1000"
  "b-route" = "5000"
}


permission_architect = [
  "user:eric.fouarge@mavenwave.com",
  "serviceAccount:terraform-admin@terraform-admin-203523.iam.gserviceaccount.com"
]

permission_engineer  = [
  "user:sky.tummala@mavenwave.com",
  "user:prem.chandra@mavenwave.com"
]

permission_user  = [
  "user:david.zhu@mavenwave.com"
]



# ----------------------------------------------------------------------------------
# INSTANCE PARAMETERS
# These parameters are for most instance deployments
# ----------------------------------------------------------------------------------
source_image       = {
  "consul"                  = "prod-companyX-admin/true-prod-base-centos6-v20180208-2200"
  "hashi-vault"             = "prod-companyX-admin/true-prod-base-centos6-v20180208-2200"
  "cloud-admin"             = "prod-companyX-admin/cloud-admin-v20180130-1100"
  "vault-zone"              = "prod-companyX-admin/true-prod-base-centos7-vsalt-v20180208-2329"
  "vmrouter"                = "prod-companyX-admin/vpc-sandwich-v20180301-0724"
  "base-centos6"            = "prod-companyX-admin/true-prod-base-centos6-v20180217-0019"
  "base-centos7"            = "prod-companyX-admin/true-prod-base-centos7-v20180302-1851"
  "base-centos6-vsalt"      = "prod-companyX-admin/true-prod-base-centos6-vsalt-v20180219-2358"
  "base-centos7-vsalt"      = "prod-companyX-admin/true-prod-base-centos7-vsalt-v20180208-2329"
  "base-centos7-4-vault"    = "prod-companyX-admin/true-prod-base-centos-k8-v20180424-2230"
  "bind"                    = "prod-companyX-admin/bind-centos7-v20180212-2213"
  "windows"                 = ""
  "saltmaster"              = "saltmaster001-20180207"
  "metrics-producer"        = "prod-companyX-admin/true-prod-base-centos7-v20180216-2342"
  "mcmono"                  = "prod-companyX-admin/true-prod-base-centos7-v20180216-2342"
  "deprecated-base-centos6" = "prod-companyX-admin/true-prod-base-centos6-v20180129-0703"
  "deprecated-base-centos7" = "prod-companyX-admin/true-prod-base-centos7-1516824392"
  "deprecated-base-centos7-vsalt" = "prod-companyX-vault/vdb-test"
}
