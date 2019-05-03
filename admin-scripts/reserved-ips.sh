#!/usr/bin/env bash

HELP="reserved-ips.sh\n\n
\t--help|-h Print this help message\n\n
\t--action [create|delete]\n
\t--project-id <GCP Project's Unique ID>\n"

HOST_PROJECT_ID=prod-shared-vpc-host-project
HOST_PROJECT_NETWORK=prod-shared-vpc-network-10-136-0-0-14

REGIONS=(us-west1 us-central1 us-east1 us-east4)

declare -A PROD_SECOND_DECIMAL
PROD_SECOND_DECIMAL[us-west1]=136
PROD_SECOND_DECIMAL[us-central1]=137
PROD_SECOND_DECIMAL[us-east1]=138
PROD_SECOND_DECIMAL[us-east4]=139

PROD_CIDR_PREFIX=22

function check_action_parameter {
    local action=$1

    case $action in
        create)
            ;;
        delete)
            ;;
        *)
            exit_on_error "The action parameter should be 'create' or 'delete'."
            ;;
    esac
}

function create_reserved_ip_address {
    local ip_address_name=$1
    local ip_address=$2
    local region=$3
    local subnetwork=$4
    local project_id=$5

    gcloud compute addresses create $ip_address_name \
    --addresses $ip_address \
    --region $region \
    --subnet $subnetwork \
    --project $project_id 2> /dev/null
}

function delete_reserved_ip_address {
    local ip_address_name=$1
    local region=$2
    local project_id=$3

    gcloud compute addresses delete $ip_address_name \
    --region $region \
    --project $project_id \
    --quiet 2> /dev/null
}

function exit_on_error {
    local message=$1

    >&2 echo
    >&2 echo "ERROR: $message"
    >&2 echo

    exit 1
}

function get_ip_address {
    local ip_address_name=$1

    local ifs_backup=$IFS
    declare -a cidr_numbers
    IFS=-
    read -r -a cidr_numbers <<< "$ip_address_name"
    IFS=$ifs_backup

    echo "${cidr_numbers[0]}.${cidr_numbers[1]}.${cidr_numbers[2]}.${cidr_numbers[3]}"

}

function get_second_decimal {
    local region=$1

    echo ${PROD_SECOND_DECIMAL[$region]}
}

function get_subnetwork {
    local project_id=$1
    local region=$2
    local network=$3

    local output=$(gcloud alpha compute networks subnets list-usable \
    --project $HOST_PROJECT_ID \
    --account shared-vpc-user@${project_id}.iam.gserviceaccount.com \
    --format json | \
    jq --arg region "$region" --arg network "$network" \
    -r '.[] |
    select(.network |
    endswith($network)) |
    select(.subnetwork |
    contains($region))')

    local subnetwork=$(echo $output | jq -r .subnetwork | rev | cut -d '/' -f 1 | rev)

    echo "projects/${HOST_PROJECT_ID}/regions/${region}/subnetworks/${subnetwork}"
}

function get_subnetwork_first_three_decimals {
    local project_id=$1
    local region=$2
    local network=$3

    local output=$(gcloud alpha compute networks subnets list-usable \
    --project $HOST_PROJECT_ID \
    --account shared-vpc-user@${project_id}.iam.gserviceaccount.com \
    --format json | \
    jq --arg region "$region" --arg network "$network" \
    -r '.[] |
    select(.network |
    endswith($network)) |
    select(.subnetwork |
    contains($region))')

    local cidr_ranges=$(echo $output | jq -r .ipCidrRange | cut -d '/' -f 1)

    local first_decimal=$(echo $cidr_ranges | cut -d '.' -f 1)
    local second_decimal=${PROD_SECOND_DECIMAL[$region]}
    local third_decimal=$(echo $cidr_ranges | cut -d '.' -f 3)

    echo "${first_decimal}-${second_decimal}-${third_decimal}"
}

function ip_address_exists {
    local ip_address_name=$1
    local project_id=$2
    local region=$3

    local output=$(gcloud compute addresses describe $ip_address_name \
        --project $project_id \
        --region $region \
        --format json 2> /dev/null | jq -r .name)

    if [[ $output == $ip_address_name ]]; then
        echo 0
    else
        echo 1
    fi
}

export -f create_reserved_ip_address delete_reserved_ip_address

function main {
    local project_id=""
    local action=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                echo
                echo -e $HELP
                exit 0
                ;;
            --action)
                action=$2
                shift
                ;;
            --project-id)
                project_id=$2
                shift
                ;;
            *)
                exit_on_error "$1 is not a valid option."
                ;;
        esac
        shift
    done

    check_action_parameter $action

    local first_three_decimals=""
    local ip_address_name=""
    local ip_address=""
    local input=""

    for region in ${REGIONS[*]}; do
        first_three_decimals=$(get_subnetwork_first_three_decimals $project_id $region $HOST_PROJECT_NETWORK)
        subnetwork=$(get_subnetwork $project_id $region $HOST_PROJECT_NETWORK)

        for i in `seq 1 128`; do
            ip_address_name="${project_id}-${first_three_decimals}-$i"
            ip_address=$(get_ip_address "${first_three_decimals}-$i")

            local output=$(ip_address_exists $ip_address_name $project_id $region)

            if [[ $action == "create" ]]; then
                if [[ $output -ne 0 ]]; then
                    input+="$ip_address_name $ip_address $region $subnetwork $project_id\n"
                fi
            fi

            if [[ $action == "delete" ]]; then
                if [[ $output -eq 0 ]]; then
                    input+="$ip_address_name $region $project_id\n"
                fi
            fi
        done
    done

    if [[ $action == "create" ]]; then
        echo -e $input | parallel --colsep ' ' --progress -j 16 create_reserved_ip_address
    fi

    if [[ $action == "delete" ]]; then
        echo -e $input | parallel --colsep ' ' --progress -j 16 delete_reserved_ip_address
    fi
}

main $@
