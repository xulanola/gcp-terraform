# ----------------------------------------------------------------------------------
# NETWORK VARIABLES
#
# ----------------------------------------------------------------------------------
variable "host_subnetwork" {}

variable "host_network" {}

variable "host_project" {}

# ----------------------------------------------------------------------------------
# INSTANCE VARIABLES
#
# ----------------------------------------------------------------------------------
variable "project_name" {}

variable "application" {}

variable forwarding_rule_ip_address {}

variable application_port {
  type = "list"
}

variable application_protocol {
  default = "tcp"
}

variable instance_group_1 {}

variable instance_group_1_zone {}

variable instance_group_2 {}

variable instance_group_2_zone {}

variable health_checompanyX_ip_ranges {
  type = "list"
}

variable domain {}

variable dns_name {}

variable environment {}
variable region {}

variable target_tags {}
