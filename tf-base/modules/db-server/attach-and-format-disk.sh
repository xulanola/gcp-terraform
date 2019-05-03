#!/usr/bin/env bash

function main {
    local device_id="/dev/sdb"

    mkfs.ext4 -m 0 -F -E lazy_itable_init=0,discard $device_id
    disk_directory=/db/data/mdb
    mkdir -p $disk_directory
    mount -o discard,defaults $device_id $disk_directory

    cp /etc/fstab /etc/fstab.backup
    blkid

    local uuid=""

    uuid=$(blkid -s UUID -o value $device_id)
    echo "$uuid $disk_directory ext4 discard,defaults,nofail 0 2" | tee -a /etc/fstab

    mkdir -p /db/data/$disk_directory/tmp
    mkdir -p /db/data/$disk_directory/logs/relaylogs
    mkdir -p /db/data/$disk_directory/logs/binlogs
    mkdir -p /db/data/$disk_directory/logs/slowlogs
    mkdir -p /db/data/$disk_directory/logs/generallogs
    chmod 755 /db/data/$disk_directory

    chown -R mysql:mysql /db/data/*
}

main
