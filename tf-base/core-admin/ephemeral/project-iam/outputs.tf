output "companyX-cloud-racompanyX-bridge" {
  value = ["${google_service_account.companyX_cloud_racompanyX_bridge.email}"]
}

output "companyX-shared-vpc" {
  value = ["${google_service_account.companyX_shared_vpc.email}"]
}

output "companyX-vault" {
  value = ["${google_service_account.companyX_vault.email}"]
}

output "companyX-bulk-vault" {
  value = ["${google_service_account.companyX_bulk_vault.email}"]
}

output "companyX-front-end" {
  value = ["${google_service_account.companyX_front_end.email}"]
}

output "companyX-back-end" {
  value = ["${google_service_account.companyX_back_end.email}"]
}

output "companyX-back-end-data" {
  value = ["${google_service_account.companyX_back_end_data.email}"]
}

output "companyX-shared-services" {
  value = ["${google_service_account.companyX_shared_services.email}"]
}

output "companyX-mgmt" {
  value = ["${google_service_account.companyX_mgmt.email}"]
}
