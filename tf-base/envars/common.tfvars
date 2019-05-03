# ----------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These parameters are required by most deployments
# ----------------------------------------------------------------------------------
region                = [
  "us-west1",
  "us-central1",
  "us-east1"

]
availability_zones    = [
"us-west1-b",
"us-west1-c"]

service_apis          = [
"compute.googleapis.com",
"cloudbilling.googleapis.com",
"dns.googleapis.com"
]

scopes                = {
  "all-api-access" = "https://www.googleapis.com/auth/cloud-platform"
}

roles                 = {
  "dnsAdmin"               = "roles/dns.admin"
  "b-storageAdmin"         = "roles/storage.admin"
  "b-computeinstanceAdmin" = "roles/compute.instanceAdmin"
  "computenetworkAdmin"    = "roles/compute.networkAdmin"
  //Only for shared-vpc project
  "computesecurityAdmin"   = "roles/compute.securityAdmin"
  //Only for shared-vpc project
  "b-computeAdmin"         = "roles/compute.admin"
  "computeimageUser"       = "roles/compute.imageUser"
  "iamserviceAccountUser"  = "roles/iam.serviceAccountUser"
  "iamserviceAccountActor" = "roles/iam.serviceAccountActor"
  //GCS Buckets
  "storageCreator"         = "roles/storage.objectCreator"
  "storageViewer"          = "roles/storage.objectViewer"
}

###
## Cloud DNS Zone
#
domain                = "companyXint.io"
companyX_com       = "companyX.com"


# ----------------------------------------------------------------------------------
# NETWORK PARAMETERS
# These parameters are for speciying networks/subnetworks/cidrs
# ----------------------------------------------------------------------------------


###
## Common CIDRs & IPs
#
cidrs                 = {
  "all"  = "0.0.0.0/0"
  "east" = "10.99.0.0/16"
  "west" = "10.101.0.0/16"
}

# ----------------------------------------------------------------------------------
# INSTANCE PARAMETERS
# These parameters are for most instance deployments
# ----------------------------------------------------------------------------------

application            = {
  "auto-insurance" = "auto-insurance"
}

machine_type          = {
  "xs"               = "n1-standard-1"
  "s"                = "n1-standard-2"
  "m"                = "n1-standard-8"
  "l"                = "n1-standard-16"
  "xl"               = "n1-standard-32"
  "xxl"              = "n1-highmem-16"
}

# count t-shirt sizes for vm deployments
deployment_size       = {
  "singleton" = "1"
  "quad"      = "4"
  "xs"        = "2"
  "s"         = "5"
  "m"         = "10"
  "l"         = "20"
  "xl"        = "30"
}

fleet_size            = {
  "singleton" = "1"
  "quad"      = "4"
  "triple"    = "3"
  "xs"        = "2"
  "s"         = "5"
  "m"         = "10"
  "l"         = "20"
  "xl"        = "32"
  "xxl"       = "50"
}

boot_disk_type        = {
  "standard" = "pd-standard"
  "ssd"      = "pd-ssd"
}


# ----------------------------------------------------------------------------------
# METADATA PARAMETERS
# These parameters are for defining instance metadata
# ----------------------------------------------------------------------------------
owner                 = {
  "vijay" = "vijay"
}
metadata              = ""

# ----------------------------------------------------------------------------------
# METADATA PARAMETERS
# Level A (hc_pii) : Any kind of highly sensitive member information Example: SSN or combination of PII (Vault db)
# Level B (pii) : Member other information Example: Security question,financials of the members etc.
# Level C (hc) : Internal - highly confidential data Example: Salt Secret Configurations, everything else which is internal
# Level D (Public) : Not-Confidential - Public
# ----------------------------------------------------------------------------------

confidentiality_level = {
  "a" = "level_a"
  "b" = "level_b"
  "c" = "level_c"
  "d" = "level_d"
}

# GCS buckets variables
storage_class = {
  "multi-regional" = "MULTI_REGIONAL"
  "regional"       = "REGIONAL"
  "nearline"       = "NEARLINE"
  "coldline"       = "COLDLINE"
}