# JIRA: CLOUD-677

#!/usr/bin/env bash

HOST_PROJECT_ID=prod-shared-vpc-host-project

for i in `seq 1 50`; do
    global_ip_name=$(printf "${HOST_PROJECT_ID}-%03d" $i)

    address=$(gcloud compute addresses create $global_ip_name \
    --project $HOST_PROJECT_ID \
    --format json \
    --global 2>/dev/null | jq -r .[].address)

    echo "$global_ip_name|$address"
done