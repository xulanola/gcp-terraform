# ====================================================================================
# Temporary script to ensure IP routes persist due to issues with GCP CentOS image
# https://github.com/GoogleCloudPlatform/compute-image-pacompanyXages/issues/475
# ====================================================================================
ip route add 10.137.112.0/24 via 10.137.115.1 dev eth0
ip route add 10.99.0.0/16 via 10.137.114.1 dev eth1
ip route add 10.101.0.0/16 via 10.137.114.1 dev eth1