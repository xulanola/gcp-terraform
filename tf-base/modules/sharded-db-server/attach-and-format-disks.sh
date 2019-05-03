#!/usr/bin/env bash

declare -A DEVICE_ID
DEVICE_ID[0]=/dev/sdb
DEVICE_ID[1]=/dev/sdc
DEVICE_ID[2]=/dev/sdd
DEVICE_ID[3]=/dev/sde

function main {
    local disk_id_=${first_disk_id}
    local device_id=""
    local uuid=""

    for offset in `seq 0 3`; do
        device_id=$${DEVICE_ID[$offset]}
        uuid=$(blkid -s UUID -o value $device_id)

        mkfs.ext4 -m 0 -F -E lazy_itable_init=0,discard $device_id
        disk_directory=/db/data/sdb$((${first_disk_id}+$offset))
        mkdir -p $disk_directory
        mount -o discard,defaults $device_id $disk_directory

        echo "$uuid $disk_directory ext4 discard,defaults,nofail 0 2" | tee -a /etc/fstab

        mkdir -p /db/data/$disk_directory/tmp
        mkdir -p /db/data/$disk_directory/logs/relaylogs
        mkdir -p /db/data/$disk_directory/logs/binlogs
        mkdir -p /db/data/$disk_directory/logs/slowlogs
        mkdir -p /db/data/$disk_directory/logs/generallogs
        chmod 755 /db/data/$disk_directory
    done
}

cp /etc/fstab /etc/fstab.backup
main
chown -R mysql:mysql /db/data/*

minion_id=$(curl --silent "http://metadata.google.internal/computeMetadata/v1/instance/attributes/companyX-hostname" -H "Metadata-Flavor: Google")
hostname $minion_id
echo "\n" >> /etc/salt/minion
echo "id: $minion_id" >> /etc/salt/minion