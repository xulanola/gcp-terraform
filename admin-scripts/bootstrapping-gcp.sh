#!/usr/bin/env bash

PARENT_FOLDER_ID=$1
ORGANIZATION_ID=$2



###
## Reference Link https://cloud.google.com/sdk/gcloud/reference/projects/create
#

gcloud projects create companyX-terraform-admin --folder $PARENT_FOLDER_ID

gcloud iam service-accounts create terraform-admin --display-name "Terraform Bootstrapping account" --project companyX-terraform-admin