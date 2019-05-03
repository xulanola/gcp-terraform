data "template_file" "startup_script" {
  template = <<EOF
#!/usr/bin/env bash

HOST_PROJECT=prod-shared-vpc-host-project

function get_availability_zone {
    local dns_zone_name=$1

    echo $(gcloud compute instances list \
    --filter="name=$HOSTNAME" \
    --format json | \
    jq -r .[].zone | \
    rev | cut -d '/' -f 1 | rev)
}

function get_canonical_hostname {
    local canonical_hostname=$(gcloud compute instances list \
    --filter="name=$HOSTNAME" \
    --format json | \
    jq -r .[].labels.hostname)

    if [[ ! -z $canonical_hostname || $canonical_hostname == "null" ]]; then
        echo $HOSTNAME
    else
        echo $canonical_hostname
    fi
}

function get_dns_name {
    local dns_zone_name=$1

    echo $(gcloud dns managed-zones describe $dns_zone_name \
    --project $HOST_PROJECT \
    --format json | \
    jq -r .dnsName)
}

function get_dns_zone_name {
    local region=$1

    echo "prod-$region-companyXint-io"
}

function get_fqdn {
    local region=$(get_region)
    local dns_zone_name=$(get_dns_zone_name $region)
    local dns_name=$(get_dns_name $dns_zone_name)
    local hostname=$(get_canonical_hostname)

    echo "$hostname.$dns_name"
}

function get_host_ip {
    local availability_zone=$1

    echo $(gcloud compute instances describe $HOSTNAME \
    --zone $availability_zone \
    --format json | jq -r .networkInterfaces[].networkIP)
}

function get_ptr_dns_zone_name {
    local region=$1
    local host_ip=$2

    local dns_zone_name=$(get_dns_zone_name $region)

    local first_octet=$(echo $host_ip | cut -d '.' -f 1)
    local second_octet=$(echo $host_ip | cut -d '.' -f 2)
    local third_octet=$(echo $host_ip | cut -d '.' -f 3)

    echo "ptr-$third_octet-$second_octet-$first_octet-$dns_zone_name"
}

function get_ptr_dns_name {
    local ptr_dns_zone_name=$1

    echo $(get_dns_name $ptr_dns_zone_name)
}

function get_region {
    local hostname=$1

    echo $(gcloud compute instances list \
    --filter="name=$HOSTNAME" \
    --format json | \
    jq -r .[].zone | \
    rev | cut -d '/' -f 1 | rev | cut -d '-' -f 1,2)
}

function add_a_record {
    local region=$(get_region)
    local dns_zone_name=$(get_dns_zone_name $region)
    local dns_name=$(get_dns_name $dns_zone_name)
    local availability_zone=$(get_availability_zone)
    local host_ip=$(get_host_ip $availability_zone)
    local hostname=$(get_canonical_hostname)

    gcloud dns record-sets transaction start \
    --zone=$dns_zone_name \
    --project=$HOST_PROJECT

    gcloud dns record-sets transaction add \
    --zone=$dns_zone_name \
    --name=$HOSTNAME.$dns_name \
    --type=A \
    --ttl=60 $host_ip \
    --project=$HOST_PROJECT

    gcloud dns record-sets transaction execute \
    --zone=$dns_zone_name \
    --project=$HOST_PROJECT

    rm -f transaction.yaml
}

function add_ptr_record {
    local region=$(get_region)
    local availability_zone=$(get_availability_zone)
    local host_ip=$(get_host_ip $availability_zone)

    local ptr_dns_zone_name=$(get_ptr_dns_zone_name $region $host_ip)
    local ptr_dns_name=$(get_ptr_dns_name $ptr_dns_zone_name)
    local fourth_octet=$(echo $host_ip | cut -d '.' -f 4)
    local fqdn=$(get_fqdn)

    gcloud dns record-sets transaction start \
    --zone=$ptr_dns_zone_name \
    --project=$HOST_PROJECT

    gcloud dns record-sets transaction add \
    --zone=$ptr_dns_zone_name \
    --name=$fourth_octet.$ptr_dns_name \
    --type=PTR \
    --ttl=60 $fqdn \
    --project=$HOST_PROJECT

    gcloud dns record-sets transaction execute \
    --zone=$ptr_dns_zone_name \
    --project=$HOST_PROJECT

    rm -f transaction.yaml
}

function set_hostname {
    local osversion=$(rpm --query centos-release | cut -d"-" -f3)

    if [[ $osversion -eq 6 ]]; then
      hostname $(curl --silent "http://metadata.google.internal/computeMetadata/v1/instance/attributes/hostname" -H "Metadata-Flavor: Google")
    else
      hostnamectl set-hostname $(curl --silent "http://metadata.google.internal/computeMetadata/v1/instance/attributes/hostname" -H "Metadata-Flavor: Google")
    fi
}

function main {
    add_a_record
    add_ptr_record
    set_hostname
}

main $@
EOF
}
